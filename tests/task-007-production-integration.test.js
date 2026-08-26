const assert = require('node:assert/strict');
const fs = require('node:fs');
const { resolveRoute } = require('../assets/js/preview-2d.js');
const html = fs.readFileSync('index.html', 'utf8');

for (const asset of ['assets/css/2d-tokens.css', 'assets/css/preview-2d.css', 'assets/js/preview-2d-state.js', 'assets/js/preview-2d.js']) assert.ok(html.includes(asset), `${asset} is integrated`);
assert.doesNotMatch(html, /name="robots"[^>]*noindex/i, 'production remains indexable');
for (const href of ['lain.html', 'about.html', 'privacy.html', 'terms.html', 'contact.html']) assert.ok(html.includes(href), `${href} remains linked`);
assert.match(fs.readFileSync('assets/js/preview-2d.js', 'utf8'), /href: 'search\.html'/, 'card market remains linked');
assert.equal(resolveRoute('https://example.test/index.html#videos', { videos: {} }), 'videos');
assert.equal(resolveRoute('https://example.test/index.html#missing', { videos: {} }), null);
assert.match(fs.readFileSync('tests/preview-2d-viewport.test.js', 'utf8'), /PREVIEW_2D_PAGE_URL/, 'browser regression can target production index');
assert.match(html, /class="ad-reserve"/);
assert.match(html, /id="menu-list"[^>]*role="listbox"/);
assert.match(html, /id="message-text"/);
assert.match(html, /<link rel="icon" href="data:image\/svg\+xml,[^"]+">/, 'production favicon is restored');
assert.match(fs.readFileSync('lain.html', 'utf8'), /<link rel="icon" href="data:image\/svg\+xml,[^"]+">/, 'Lain keeps its mode-specific favicon');
console.log('TASK-007 production integration contract test: PASS');
