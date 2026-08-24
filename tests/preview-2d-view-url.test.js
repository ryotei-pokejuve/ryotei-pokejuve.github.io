const assert = require('node:assert/strict');
const fs = require('node:fs');
const { resolveView } = require('../assets/js/preview-2d.js');

const cases = [
  ['https://example.test/preview-2d.html', 'no view parameter'],
  ['https://example.test/preview-2d.html?view=2d', 'explicit 2D'],
  ['https://example.test/preview-2d.html?view=3d', 'unavailable 3D'],
  ['https://example.test/preview-2d.html?view=vr', 'unknown view'],
  ['https://example.test/preview-2d.html?x=1&view=3d#profile', 'query and existing hash'],
  ['not a valid absolute URL?view=3d#top', 'relative or malformed input'],
  [undefined, 'missing URL value'],
];

for (const [url, label] of cases) {
  assert.equal(resolveView(url), '2d', `${label} safely resolves to the available 2D view`);
}

const html = fs.readFileSync('preview-2d.html', 'utf8');
const scriptSources = [...html.matchAll(/<script\b[^>]*\bsrc=["']([^"']+)["']/gi)]
  .map((match) => match[1]);

assert.deepEqual(
  scriptSources,
  ['content.js', 'assets/js/preview-2d-state.js', 'assets/js/preview-2d.js'],
  'preview keeps its existing script requests only',
);
assert.doesNotMatch(html, /three(?:\.min)?\.js|webgl|unity/i, 'preview does not load a 3D runtime');

console.log('preview-2d view URL fallback test: PASS');
