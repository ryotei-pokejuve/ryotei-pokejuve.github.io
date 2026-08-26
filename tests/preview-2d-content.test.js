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
const { createEntities } = require('../assets/js/preview-2d.js');
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

const entities = createEntities(PAGES, PAGE_ORDER);
assert.equal(
  entities.map(({ id }) => id).join(','),
  Array.from(PAGE_ORDER).concat('market').join(','),
  'the renderer-independent adapter keeps every ordered page and appends CARD MARKET',
);
for (const [index, id] of PAGE_ORDER.entries()) {
  assert.deepEqual(Object.keys(entities[index]).sort(), ['href', 'id', 'kind', 'page', 'title'], `${id} exposes only entity fields`);
  assert.equal(entities[index].page, PAGES[id], `${id} keeps its existing page reference`);
  assert.equal(entities[index].title, PAGES[id].title || id, `${id} keeps its existing display title`);
  assert.equal(entities[index].kind, 'content', `${id} is identified as content`);
  assert.equal(entities[index].href, null, `${id} has no external destination`);
}
assert.deepEqual(
  entities.at(-1),
  { id: 'market', title: 'CARD MARKET', kind: 'external', href: 'search.html', page: null },
  'CARD MARKET keeps its existing destination without a synthetic page',
);
assert.deepEqual(createEntities(null, null).map(({ id }) => id), ['market'], 'the adapter is callable without DOM globals');

console.log('preview-2d real content contract test: PASS');
