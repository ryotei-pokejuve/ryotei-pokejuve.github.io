const assert = require('node:assert/strict');
const fs = require('node:fs');

const html = fs.readFileSync('index.html', 'utf8');
const title = 'りょていのサイト｜ポケカ開封・引退品のYouTube動画';
const description = 'ポケモンカードの開封や引退品を中心に発信する、りょていのYouTube活動サイト。投稿動画、Shorts、ライブ配信、カード相場検索をまとめています。';
const canonicalUrl = 'https://ryotei-pokejuve.github.io/';

assert.match(html, new RegExp(`<title>${title}</title>`), 'the existing title remains unchanged');
assert.match(
  html,
  new RegExp(`<meta name="description" content="${description}">`),
  'the existing description remains unchanged',
);
assert.match(html, new RegExp(`<link rel="canonical" href="${canonicalUrl}">`));
assert.match(html, new RegExp(`<meta property="og:title" content="${title}">`));
assert.match(html, new RegExp(`<meta property="og:description" content="${description}">`));
assert.match(html, /<meta property="og:type" content="website">/);
assert.match(html, new RegExp(`<meta property="og:url" content="${canonicalUrl}">`));

console.log('TASK-003 SEO metadata contract test: PASS');
