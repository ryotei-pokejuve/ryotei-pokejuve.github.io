import csv
import html
import json
import re
import sys
import time
from pathlib import Path
from urllib.parse import urljoin

try:
    import requests
    from bs4 import BeautifulSoup
except ImportError:
    print('requests / beautifulsoup4 が必要です。')
    print('PowerShellで: pip install requests beautifulsoup4')
    input('\nEnterで終了...')
    raise

BASE = 'https://scrydex.com'
EXPANSIONS_URL = BASE + '/pokemon/jp/expansions'

# 現在DBのMEGA期コード -> Scrydex expansion id
SET_MAP = {
    'M1L': 'm1l_ja',
    'M1S': 'm1s_ja',
    'MA': 'ma_ja',
    'MBD': 'mbd_ja',
    'MBG': 'mbg_ja',
    'M-P': 'mp_ja',
    'M2': 'm2_ja',
    'M2a': 'm2a_ja',
    'MC': 'mc_ja',
    'MP1': 'mp1_ja',
    'M3': 'm3_ja',
    'M4': 'm4_ja',
    'M5': 'm5_ja',
    'M6': 'm6_ja',
}

RARITY_MAP = {
    # English labels shown on Scrydex
    'Common': 'C',
    'Uncommon': 'U',
    'Rare': 'R',
    'Double Rare': 'RR',
    'Art Rare': 'AR',
    'Super Rare': 'SR',
    'Special Art Rare': 'SAR',
    'Mega Ultra Rare': 'MUR',
    'Promo': 'PROMO',

    # Japanese values seen on Scrydex pages/data
    '通常': 'C',
    '非': 'U',
    '希少': 'R',
    'ダブルレア': 'RR',
    'アートレア': 'AR',
    'スーパーレア': 'SR',
    'スペシャルアートレア': 'SAR',
    '超ウルトラレア': 'MUR',
    'プロモ': 'PROMO',
}

UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/152 Safari/537.36'
session = requests.Session()
session.headers.update({'User-Agent': UA, 'Accept-Language': 'ja,en;q=0.8'})


def find_export_files():
    here = Path(__file__).resolve().parent
    candidates = [
        here,
        here / 'supabase_export_db',
        here / 'supabase_export',
        here.parent / 'supabase_export_db',
        here.parent / 'supabase_export',
    ]
    for folder in candidates:
        cards = folder / 'cards.csv'
        sets = folder / 'card_sets.csv'
        if cards.exists() and sets.exists():
            return cards, sets
    raise FileNotFoundError(
        'cards.csv と card_sets.csv が見つかりません。'
        'このスクリプトをCSVと同じフォルダか、その1つ上のフォルダに置いてください。'
    )


def get(url, timeout=30, tries=4):
    last = None
    for i in range(tries):
        try:
            r = session.get(url, timeout=timeout)
            if r.status_code == 200:
                return r
            last = RuntimeError(f'HTTP {r.status_code}: {url}')
        except Exception as e:
            last = e
        time.sleep(1.0 + i * 1.5)
    raise last


def normalize_number(value):
    if value is None:
        return ''
    s = str(value).strip()
    if '/' in s:
        s = s.split('/', 1)[0]
    if re.fullmatch(r'\d+', s):
        return str(int(s))
    return s.upper()


def load_db(cards_path, sets_path):
    with open(sets_path, newline='', encoding='utf-8-sig') as f:
        sets = list(csv.DictReader(f))
    id_to_code = {r['id']: r.get('code', '') for r in sets}

    rows = []
    with open(cards_path, newline='', encoding='utf-8-sig') as f:
        for r in csv.DictReader(f):
            code = id_to_code.get(r.get('set_id', ''), '')
            if code in SET_MAP:
                r['_set_code'] = code
                r['_number_norm'] = normalize_number(r.get('card_number'))
                rows.append(r)
    return rows


def discover_expansion_urls():
    print('Scrydex 日本語拡張一覧を取得中...')
    soup = BeautifulSoup(get(EXPANSIONS_URL).text, 'html.parser')
    found = {}
    for a in soup.find_all('a', href=True):
        href = a['href']
        for code, sid in SET_MAP.items():
            if href.rstrip('/').endswith('/' + sid):
                found[code] = urljoin(BASE, href)
    return found


def discover_cards(expansion_url, sid):
    soup = BeautifulSoup(get(expansion_url).text, 'html.parser')
    out = {}
    pat = re.compile(rf'/{re.escape(sid)}-([A-Za-z0-9]+)$')
    for a in soup.find_all('a', href=True):
        href = a['href'].split('?', 1)[0].rstrip('/')
        if '/pokemon/cards/' not in href:
            continue
        m = pat.search(href)
        if not m:
            continue
        num = normalize_number(m.group(1))
        out[num] = urljoin(BASE, href)
    return out


def extract_rarity(page_text):
    raw = html.unescape(page_text)

    # JSON / serialized data first.
    patterns = [
        r'"rarity"\s*:\s*"([^"]+)"',
        r'rarity\\?"\s*:\s*\\?"([^"\\]+)',
    ]
    values = []
    for pat in patterns:
        values.extend(re.findall(pat, raw, flags=re.I))

    # Visible HTML fallback.
    soup = BeautifulSoup(page_text, 'html.parser')
    text = '\n'.join(s.strip() for s in soup.stripped_strings)
    for label in sorted(RARITY_MAP, key=len, reverse=True):
        if re.search(r'\bRarity\b.{0,120}' + re.escape(label), text, re.I | re.S):
            values.append(label)

    # Prefer an exact known rarity label.
    for v in values:
        v = html.unescape(v).strip()
        if v in RARITY_MAP:
            return v, RARITY_MAP[v]

    # Broader visible-label scan.
    for label in sorted(RARITY_MAP, key=len, reverse=True):
        if label in text:
            # Avoid using generic words from unrelated areas unless close to "Rarity".
            pos = text.find(label)
            rarity_pos = text.rfind('Rarity', max(0, pos - 300), pos + 1)
            if rarity_pos != -1:
                return label, RARITY_MAP[label]

    return '', ''


def qlit(s):
    if s is None:
        return 'NULL'
    return "'" + str(s).replace("'", "''") + "'"


def main():
    cards_path, sets_path = find_export_files()
    print('DB CSV:')
    print(' ', cards_path)
    print(' ', sets_path)

    db_rows = load_db(cards_path, sets_path)
    db_index = {}
    for r in db_rows:
        db_index.setdefault((r['_set_code'], r['_number_norm']), []).append(r)

    expansion_urls = discover_expansion_urls()
    missing_expansions = [c for c in SET_MAP if c not in expansion_urls]
    if missing_expansions:
        print('一覧ページからURLを発見できなかったセット:', ', '.join(missing_expansions))

    outdir = Path(__file__).resolve().parent / 'mega_rarity_audit'
    outdir.mkdir(exist_ok=True)

    scraped = {}
    errors = []

    for code, sid in SET_MAP.items():
        url = expansion_urls.get(code)
        if not url:
            continue

        print(f'\n[{code}] {url}')
        try:
            card_urls = discover_cards(url, sid)
        except Exception as e:
            errors.append((code, '', url, str(e)))
            print('  expansion取得失敗:', e)
            continue

        print(f'  公開ページ上のカードリンク: {len(card_urls)}件')

        done = 0
        for number, card_url in card_urls.items():
            key = (code, number)
            # DBにないカードも収集しておくが、比較対象は後で絞る。
            try:
                page = get(card_url)
                source_label, rarity_code = extract_rarity(page.text)
                scraped[key] = {
                    'source_label': source_label,
                    'rarity_code': rarity_code,
                    'url': card_url,
                }
                if not rarity_code:
                    errors.append((code, number, card_url, 'rarity parse failed'))
            except Exception as e:
                errors.append((code, number, card_url, str(e)))

            done += 1
            if done % 25 == 0 or done == len(card_urls):
                print(f'  {done}/{len(card_urls)}')
            time.sleep(0.12)

    audit = []
    for key, rows in sorted(db_index.items()):
        code, number = key
        src = scraped.get(key)
        for r in rows:
            current = (r.get('rarity') or '').strip()
            if src:
                expected = src['rarity_code']
                status = (
                    'MATCH' if expected and current == expected
                    else 'CHANGE' if expected
                    else 'NO_RARITY'
                )
                source_label = src['source_label']
                source_url = src['url']
            else:
                expected = ''
                source_label = ''
                source_url = ''
                status = 'NOT_FOUND_ON_SCRYDEX'

            audit.append({
                'card_id': r.get('id', ''),
                'set_code': code,
                'card_number': r.get('card_number', ''),
                'card_name': r.get('name', ''),
                'current_rarity': current,
                'scrydex_rarity': expected,
                'scrydex_label': source_label,
                'status': status,
                'scrydex_url': source_url,
            })

    audit_path = outdir / 'mega_rarity_audit.csv'
    with open(audit_path, 'w', newline='', encoding='utf-8-sig') as f:
        w = csv.DictWriter(f, fieldnames=list(audit[0].keys()) if audit else [
            'card_id','set_code','card_number','card_name','current_rarity',
            'scrydex_rarity','scrydex_label','status','scrydex_url'
        ])
        w.writeheader()
        w.writerows(audit)

    changes = [r for r in audit if r['status'] == 'CHANGE']
    change_path = outdir / 'mega_rarity_changes_only.csv'
    with open(change_path, 'w', newline='', encoding='utf-8-sig') as f:
        fields = list(audit[0].keys()) if audit else []
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader()
        w.writerows(changes)

    # Safe SQL: only changes rows whose current rarity still equals the exported value.
    sql_path = outdir / 'mega_rarity_update_previewed.sql'
    lines = [
        '-- MEGA rarity correction generated from Scrydex PUBLIC card pages.',
        '-- No Scrydex API is used.',
        '-- Safety: UPDATE only if the DB rarity still equals the value seen in the exported cards.csv.',
        '',
        'BEGIN;',
        '',
        'CREATE TABLE IF NOT EXISTS public.mega_rarity_backup_20260829 (',
        '    card_id uuid PRIMARY KEY,',
        '    old_rarity text,',
        '    backed_up_at timestamptz NOT NULL DEFAULT now()',
        ');',
        '',
    ]
    for r in changes:
        cid = r['card_id']
        old = r['current_rarity']
        new = r['scrydex_rarity']
        lines += [
            f'-- {r["set_code"]} {r["card_number"]} {r["card_name"]} : {old or "NULL/blank"} -> {new}',
            'INSERT INTO public.mega_rarity_backup_20260829(card_id, old_rarity)',
            f'SELECT id, rarity FROM public.cards WHERE id = {qlit(cid)}',
            'ON CONFLICT (card_id) DO NOTHING;',
            'UPDATE public.cards',
            f'SET rarity = {qlit(new)}, updated_at = now()',
            f'WHERE id = {qlit(cid)}',
            f'  AND COALESCE(rarity, \'\') = {qlit(old)};',
            '',
        ]
    lines += ['COMMIT;', '']
    sql_path.write_text('\n'.join(lines), encoding='utf-8')

    rollback_path = outdir / 'mega_rarity_rollback.sql'
    rollback_path.write_text(
        """BEGIN;
UPDATE public.cards c
SET rarity = b.old_rarity,
    updated_at = now()
FROM public.mega_rarity_backup_20260829 b
WHERE c.id = b.card_id;
COMMIT;
""",
        encoding='utf-8',
    )

    err_path = outdir / 'scrydex_errors.csv'
    with open(err_path, 'w', newline='', encoding='utf-8-sig') as f:
        w = csv.writer(f)
        w.writerow(['set_code','card_number','url','error'])
        w.writerows(errors)

    summary = {
        'db_mega_rows': len(audit),
        'scrydex_cards_parsed': sum(1 for v in scraped.values() if v['rarity_code']),
        'matches': sum(1 for r in audit if r['status'] == 'MATCH'),
        'changes': len(changes),
        'no_rarity_parsed': sum(1 for r in audit if r['status'] == 'NO_RARITY'),
        'not_found_on_scrydex': sum(1 for r in audit if r['status'] == 'NOT_FOUND_ON_SCRYDEX'),
        'request_or_parse_errors': len(errors),
    }
    (outdir / '_summary.txt').write_text(
        '\n'.join(f'{k}: {v}' for k, v in summary.items()) + '\n',
        encoding='utf-8',
    )

    print('\n=== 完了 ===')
    for k, v in summary.items():
        print(f'{k}: {v}')
    print('\n出力先:', outdir)
    print('まず mega_rarity_changes_only.csv と _summary.txt をChatGPTにアップロードしてください。')
    print('まだ SQL は実行しないでください。')
    input('\nEnterで終了...')


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('\n中断しました。')
        sys.exit(1)
    except Exception as e:
        print('\nERROR:', type(e).__name__, e)
        input('\nEnterで終了...')
        raise
