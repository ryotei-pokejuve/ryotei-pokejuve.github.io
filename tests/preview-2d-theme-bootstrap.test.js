const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

const html = fs.readFileSync('preview-2d.html', 'utf8');
const script = html.match(/<script>\s*([\s\S]*?)\s*<\/script>/);
assert.ok(script, 'the early theme bootstrap exists');

function bootstrap({ getItem, matchMedia } = {}) {
  const context = {
    document: { documentElement: { dataset: { theme: 'dark' } } },
    localStorage: { getItem: getItem || (() => null) },
  };
  if (matchMedia) context.matchMedia = matchMedia;
  vm.runInNewContext(script[1], context);
  return context.document.documentElement.dataset.theme;
}

assert.equal(
  bootstrap({ getItem: () => 'light', matchMedia: () => ({ matches: false }) }),
  'light',
  'a valid stored theme wins over the system preference',
);
assert.equal(
  bootstrap({ getItem: () => { throw new Error('storage disabled'); } }),
  'dark',
  'blocked storage and missing matchMedia fall back safely to dark',
);
assert.equal(
  bootstrap({ getItem: () => 'invalid', matchMedia: () => ({ matches: true }) }),
  'light',
  'an invalid stored value falls back to the system preference',
);

console.log('preview-2d theme bootstrap regression test: PASS');
