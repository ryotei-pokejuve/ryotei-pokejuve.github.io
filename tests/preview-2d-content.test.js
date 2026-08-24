const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

const source = fs.readFileSync('content.js', 'utf8');
const sandbox = {
  window: {},
  document: { querySelector() { return null; } },
  fetch() { return Promise.reject(new Error('network disabled in content contract test')); },
  URL,
  Promise,
  Number,
  encodeURIComponent,
};

vm.runInNewContext(source, sandbox);

const { PAGES, PAGE_ORDER } = sandbox.window.SITE;
assert.deepEqual(
  Array.from(PAGE_ORDER),
  ['top', 'videos', 'shorts', 'pokeca', 'live', 'achievements', 'profile', 'history', 'blog', 'sns'],
  'the preview keeps all ten real content screens in their established order',
);

for (const id of PAGE_ORDER) {
  const page = PAGES[id];
  assert.ok(page && page.title, `${id} keeps its real title`);
  const html = typeof page.html === 'function' ? page.html() : page.html;
  assert.equal(typeof html, 'string', `${id} renders HTML from content.js`);
  assert.doesNotMatch(html, /NOTA-II|SPECIMENS|AREAS|架空の標本|架空の区域/, `${id} contains no design dummy data`);
}

for (const id of ['videos', 'shorts', 'pokeca', 'live', 'achievements']) {
  const html = PAGES[id].html();
  assert.match(html, /yt-async/, `${id} keeps the shared API-backed panel`);
  assert.match(html, /よみこみちゅう/, `${id} starts with an honest loading state`);
  assert.equal(typeof PAGES[id].onMount, 'function', `${id} keeps its existing onMount hook`);
}

assert.match(PAGES.history.html(), /class="log-list"/, 'history keeps its real hierarchical list');
assert.match(PAGES.blog.html(), /class="blog-post"/, 'blog keeps its real article panels');
assert.match(PAGES.sns.html(), /id="sns-links"/, 'SNS keeps its real external link collection');

console.log('preview-2d real content contract test: PASS');
