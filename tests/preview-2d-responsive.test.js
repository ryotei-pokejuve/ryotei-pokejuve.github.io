const assert = require('node:assert/strict');
const fs = require('node:fs');

const html = fs.readFileSync('preview-2d.html', 'utf8');
const css = fs.readFileSync('assets/css/preview-2d.css', 'utf8');

function rule(selector, source = css) {
  const escaped = selector.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const match = source.match(new RegExp(`${escaped}\\s*\\{([^}]+)\\}`));
  assert.ok(match, `missing CSS rule: ${selector}`);
  return match[1];
}

function mediaBlock(start, end) {
  const startIndex = css.indexOf(start);
  const endIndex = css.indexOf(end, startIndex + start.length);
  assert.ok(startIndex >= 0 && endIndex > startIndex, `missing media block: ${start}`);
  return css.slice(startIndex, endIndex);
}

assert.match(
  html,
  /<meta\s+name=["']viewport["']\s+content=["']width=device-width,\s*initial-scale=1["']>/i,
  'the preview uses the device viewport on mobile',
);
assert.match(rule('html'), /min-width:\s*320px/, 'the supported viewport floor is explicit');

const shellRule = rule('.terminal-shell');
assert.match(shellRule, /border:\s*4px\s+solid\s+var\(--terminal-edge\)/, 'the terminal has the strong A-variant outer frame');
assert.match(shellRule, /repeating-linear-gradient/, 'the terminal frame uses a restrained tile treatment');
assert.match(shellRule, /inset\s+0\s+0\s+0\s+2px\s+var\(--terminal-ring\)/, 'the terminal outer frame includes an inner ring');
assert.match(
  rule('.terminal-shell > .win2'),
  /inset\s+0\s+0\s+0\s+5px\s+var\(--card\)/,
  'status, main, and message windows share the multi-ring hierarchy',
);

assert.match(html, /<dl class="hud-readouts" aria-label="端末ステータス">/, 'HUD readouts retain their accessible group label');
assert.match(html, /<span class="hud-signal" aria-hidden="true">/, 'decorative HUD signal is hidden from assistive technology');
assert.match(rule('.hud-readouts'), /border:\s*2px\s+solid\s+var\(--terminal-edge\)/, 'HUD readouts form an A-variant segmented status unit');
assert.match(rule('.hud-readout + .hud-readout'), /border-left:\s*2px\s+solid\s+var\(--terminal-edge\)/, 'HUD status values have strong internal segment rules');
assert.match(css, /\.status-bar::before\s*\{[^}]*border-width:\s*2px\s+0\s+0\s+2px/, 'HUD retains its upper corner bracket');
assert.match(css, /\.status-bar::after\s*\{[^}]*border-width:\s*0\s+2px\s+2px\s+0/, 'HUD retains its lower corner bracket');

const hudMedia = mediaBlock('@media (max-width: 850px)', '@media (max-width: 760px)');
assert.match(
  rule('.status-bar', hudMedia),
  /grid-template-columns:\s*minmax\(0,\s*1fr\)\s+auto\s+auto/,
  'the HUD wraps before its four desktop columns can collide',
);
assert.match(rule('.hud-readouts', hudMedia), /grid-column:\s*1\s*\/\s*-1/, 'HUD readouts occupy a safe second row through 761px');

const tabletMedia = mediaBlock('@media (max-width: 760px)', '@media (max-width: 430px)');
assert.match(
  tabletMedia,
  /\.menu-list\s*\{[^}]*grid-template-columns:\s*repeat\(2,\s*minmax\(0,\s*1fr\)\)/,
  'the compact menu keeps two shrinkable columns',
);

const mobileMedia = mediaBlock('@media (max-width: 430px)', '@media (prefers-reduced-motion: reduce)');
assert.match(rule('.terminal-shell', mobileMedia), /width:\s*100%/, 'the framed terminal fits the 320px mobile floor');
assert.match(rule('.terminal-shell', mobileMedia), /border-width:\s*3px/, 'the outer frame remains visible without consuming mobile content width');
assert.match(rule('.hud-signal', mobileMedia), /display:\s*none/, 'decorative signal yields space at narrow mobile widths');
assert.match(rule('.menu-item', mobileMedia), /min-height:\s*48px/, 'mobile menu items exceed 44px');
assert.match(rule('#theme-toggle'), /min-height:\s*44px/, 'the theme control meets the touch target minimum');
assert.match(rule('.open-link'), /min-height:\s*44px/, 'external actions meet the touch target minimum');

assert.match(html, /id="message-heading" class="message-label">MESSAGE<\/span>/, 'MESSAGE uses the A-variant label plate');
assert.match(html, /<kbd>↑↓ SELECT<\/kbd><kbd>ENTER OPEN<\/kbd><kbd>ESC MENU<\/kbd>/, 'keyboard hints are grouped into readable key plates');
assert.match(html, /class="message-caret" aria-hidden="true"/, 'the decorative waiting caret is hidden from assistive technology');
assert.match(rule('.terminal-shell > .message-window'), /inset\s+0\s+0\s+0\s+2px\s+var\(--accent\)/, 'MESSAGE has the strong A-variant inner accent ring');
assert.match(rule('.message-label'), /border:\s*2px\s+solid\s+var\(--terminal-edge\)/, 'MESSAGE label is a square double-framed plate');
assert.match(rule('#message-text'), /line-height:\s*1\.75/, 'MESSAGE body keeps the B-variant readable line height');
assert.match(rule('.message-window', mobileMedia), /padding:\s*18px\s+30px\s+12px\s+12px/, 'MESSAGE reserves caret space without overflowing narrow screens');
const reducedMotionMedia = css.slice(css.indexOf('@media (prefers-reduced-motion: reduce)'));
assert.match(rule('.message-caret', reducedMotionMedia), /transform:\s*none/, 'reduced motion stops the decorative waiting caret');

assert.match(html, /id="detail-code" class="detail-code" aria-hidden="true"/, 'the content title plate has a decorative data code');
assert.match(rule('.detail-heading'), /border-bottom:\s*3px\s+solid\s+var\(--terminal-edge\)/, 'the content title plate has a strong A-variant divider');
assert.match(rule('.page-content'), /border:\s*var\(--bw\)\s+solid\s+var\(--edge\)/, 'real content is contained in an information sub-panel');
assert.match(rule('.detail-content .yt-async'), /min-height:\s*96px/, 'API-backed empty and loading states reserve a stable panel');

const menuRule = rule('.menu-item');
const selectedMenuRule = rule('.menu-item[aria-selected="true"]');
assert.match(menuRule, /min-height:\s*46px/, 'desktop menu items exceed the 44px touch target');
assert.match(menuRule, /touch-action:\s*manipulation/, 'menu taps use the same click activation path without delayed gesture handling');
assert.match(rule('.menu-item:hover'), /background:\s*var\(--sel-bg\)/, 'hover has a restrained preview state');
assert.match(rule('.menu-item:focus-visible'), /outline-color:\s*var\(--text\)/, 'keyboard focus remains visible independently of selection');
assert.match(
  rule('.menu-item[aria-selected="true"]:focus-visible'),
  /outline-color:\s*var\(--accent-ink\)/,
  'keyboard focus keeps non-text contrast on the selected accent background',
);
assert.match(selectedMenuRule, /background:\s*var\(--accent\)/, 'selection uses the A-variant full inversion');
assert.match(selectedMenuRule, /color:\s*var\(--accent-ink\)/, 'selected text keeps contrast on the inverted row');
assert.match(selectedMenuRule, /border-left-color:\s*var\(--terminal-edge\)/, 'selection keeps a non-color-independent left rail');
assert.match(selectedMenuRule, /box-shadow:\s*var\(--menu-press-shadow\)/, 'selection has the A-variant raised bevel');
assert.match(rule('.menu-item:active'), /transform:\s*translateY\(2px\)/, 'pressing a row has a distinct depressed state');
assert.match(rule('.menu-item[aria-selected="true"]::before'), /content:\s*"▶"/, 'selection includes a non-color cursor marker');
assert.match(
  rule('.menu-item[aria-selected="true"] .menu-kind'),
  /color:\s*var\(--accent-ink\)/,
  'selected metadata participates in the full inversion',
);

const adRule = rule('.ad-reserve');
assert.match(adRule, /min-height:\s*90px/, 'the desktop/tablet ad slot reserves height');
assert.doesNotMatch(adRule, /position:\s*(?:absolute|fixed|sticky)/, 'the ad slot stays in normal flow');
assert.match(rule('.ad-reserve', mobileMedia), /min-height:\s*100px/, 'the mobile ad slot reserves height');
assert.ok(
  html.indexOf('class="message-window') < html.indexOf('class="ad-reserve'),
  'the reserved ad slot remains directly after the message area',
);

console.log('preview-2d responsive contract test: PASS');
