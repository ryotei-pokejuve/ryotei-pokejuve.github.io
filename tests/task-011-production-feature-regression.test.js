const assert = require('node:assert/strict');
const fs = require('node:fs');
const { createEntities } = require('../assets/js/preview-2d.js');

const indexHtml = fs.readFileSync('index.html', 'utf8');
const lainHtml = fs.readFileSync('lain.html', 'utf8');
const rendererSource = fs.readFileSync('assets/js/preview-2d.js', 'utf8');

assert.match(
  indexHtml,
  /id="push-start-gate"/,
  'production exposes the PUSH START gate',
);
assert.match(
  indexHtml,
  /<button id="sound-toggle"[^>]*type="button"[^>]*aria-label="[^"]+"[^>]*aria-pressed="false"/,
  'production keeps an accessible, default-OFF sound toggle',
);

assert.match(lainHtml, /id="sound-toggle"/, 'Lain keeps its mode-specific sound toggle');
assert.match(lainHtml, /soundToggle\.addEventListener\("click"/, 'Lain owns its sound-toggle behavior');
assert.doesNotMatch(lainHtml, /assets\/js\/preview-2d\.js/, 'Lain does not depend on the production renderer sound control');

const pushStartKey = rendererSource.match(/var PUSH_START_KEY = '([^']+)'/);
const warpEntryKey = rendererSource.match(/var WARP_ENTRY_KEY = '([^']+)'/);
assert.ok(pushStartKey, 'the PUSH START session key is declared explicitly');
assert.ok(warpEntryKey, 'the Lain return warp session key is declared explicitly');
assert.notEqual(pushStartKey[1], warpEntryKey[1], 'PUSH START and warp entry use independent session keys');
assert.match(lainHtml, /sessionStorage\.setItem\("ryotei-warp-entry", "1"\)/, 'Lain return still requests the production warp entry');

for (const id of ['screen-name', 'status-position', 'status-theme', 'menu-list', 'detail-content', 'message-text']) {
  assert.match(indexHtml, new RegExp(`id="${id}"`), `${id} remains in the production 2D shell`);
}

const entities = createEntities({ top: { title: 'TOP' } }, ['top']);
assert.deepEqual(
  entities.at(-1),
  { id: 'market', title: 'CARD MARKET', kind: 'external', href: 'search.html', page: null },
  'CARD MARKET remains the final production menu destination',
);

console.log('TASK-011 production feature regression test: PASS');
