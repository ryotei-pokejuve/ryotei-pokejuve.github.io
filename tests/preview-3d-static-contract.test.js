const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..');
const html = fs.readFileSync(path.join(root, 'preview-3d.html'), 'utf8');
const host = fs.readFileSync(path.join(root, 'assets/js/preview-3d-host.js'), 'utf8');
const css = fs.readFileSync(path.join(root, 'assets/css/preview-3d.css'), 'utf8');

assert.match(html, /<html\s+lang="ja">/i, '3D preview declares Japanese content');
assert.match(
  html,
  /<meta\s+name="robots"\s+content="noindex, nofollow">/i,
  '3D preview is excluded from indexing',
);
assert.match(html, /<title>3D MODE Preview \| RYOTEI<\/title>/, '3D preview has the approved title');
assert.match(
  html,
  /<canvas\b[^>]*\bid="unity-canvas"[^>]*\btabindex="-1"[^>]*>/i,
  '3D preview provides the Unity canvas',
);
assert.match(html, /id="unity-loading"[^>]*role="status"/i, 'loading status is exposed');
assert.match(html, /id="unity-progress"/i, 'loading progress is exposed');
assert.match(html, /id="unity-progress-text"/i, 'loading percentage is exposed');
assert.match(html, /id="unity-error"[^>]*role="alert"/i, 'failure UI is exposed as an alert');
assert.match(
  html,
  /<a\b[^>]*href="preview-2d\.html"[^>]*>/i,
  'a normal link back to the 2D preview remains available',
);

const assetUrls = [
  ...html.matchAll(/<(?:link|script)\b[^>]*(?:href|src)="([^"]+)"[^>]*>/gi),
].map((match) => match[1]);

assert.deepEqual(
  assetUrls,
  ['assets/css/preview-3d.css', 'assets/js/preview-3d-host.js'],
  '3D preview loads only its dedicated CSS and host JavaScript',
);
for (const url of [...assetUrls, 'preview-2d.html']) {
  assert.doesNotMatch(url, /^(?:\/|https?:\/\/)/i, `${url} must remain a relative path`);
}

for (const forbiddenAsset of [
  'content.js',
  'preview-2d-state.js',
  'preview-2d.js',
  '2d-tokens.css',
  'preview-2d.css',
]) {
  assert.ok(
    !assetUrls.some((url) => url.endsWith(forbiddenAsset)),
    `3D preview must not load ${forbiddenAsset}`,
  );
}

assert.doesNotMatch(html, /https?:\/\//i, '3D preview does not load external URLs');
assert.doesNotMatch(html, /\b(?:three(?:\.min)?\.js|babylon(?:\.min)?\.js|aframe)\b/i, 'fallback 3D engines are not included');
assert.doesNotMatch(html, /http-equiv="Content-Security-Policy"/i, 'meta CSP is intentionally deferred for Unity WebAssembly');

assert.doesNotMatch(host, /\balert\s*\(/, '3D host reports errors in-page instead of using alert');
assert.doesNotMatch(host, /https?:\/\//i, '3D host does not load external URLs');
assert.doesNotMatch(css, /https?:\/\//i, '3D styles do not load external URLs');
assert.doesNotMatch(css, /\burl\s*\(/i, '3D styles do not load image or font assets');
assert.doesNotMatch(css, /@import\b/i, '3D styles do not import external styles or fonts');
assert.deepEqual(
  [...new Set(host.match(/RYOTEI_[A-Z0-9_]+/g) || [])],
  ['RYOTEI_HOST_3D'],
  '3D host uses only its approved RYOTEI_HOST_3D global name',
);
assert.doesNotMatch(host, /unityShowBanner/, '3D host does not reuse Unity template banner code');

console.log('preview-3d static contract test: PASS');
