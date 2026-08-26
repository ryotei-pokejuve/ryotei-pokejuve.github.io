const assert = require('node:assert/strict');
const fs = require('node:fs');

const html = fs.readFileSync('index.html', 'utf8');
const renderer = fs.readFileSync('assets/js/preview-2d.js', 'utf8');

const h1s = [...html.matchAll(/<h1(?:\s[^>]*)?>/g)];
assert.equal(h1s.length, 1, 'production keeps one primary heading');
assert.match(html, /<main\s+class="terminal-shell"[^>]*aria-labelledby="terminal-title"/,
  'the primary landmark is named by the primary heading');

const gateTag = html.match(/<[^>]+id="push-start-gate"[^>]*>/);
assert.ok(gateTag, 'production exposes the PUSH START gate');
assert.match(gateTag[0], /role="dialog"/, 'PUSH START uses dialog semantics');
assert.match(gateTag[0], /aria-modal="true"/, 'PUSH START is exposed as modal while active');
assert.match(gateTag[0], /aria-labelledby="[^"]+"/, 'PUSH START has an accessible label reference');
const gateLabel = gateTag[0].match(/aria-labelledby="([^"]+)"/);
assert.ok(gateLabel && new RegExp(`id="${gateLabel[1]}"`).test(html), 'the PUSH START dialog label exists');
const startButton = html.match(/<button[^>]+id="push-start-button"[^>]*>/);
assert.ok(startButton, 'PUSH START uses a keyboard and pointer accessible native button');
assert.match(startButton[0], /type="button"/, 'PUSH START does not submit a form');
assert.match(renderer, /PUSH_START_KEY/, 'PUSH START keeps an independent session contract');
assert.match(renderer, /event\.key\s*===?\s*['"]Tab['"]|case\s+['"]Tab['"]/,
  'the modal explicitly contains Tab focus while it is active');
assert.match(renderer, /pushStart[^\n]*\.focus\(|pushStartButton[^\n]*\.focus\(/i,
  'the modal moves focus to its start control');

assert.match(
  html,
  /<button id="sound-toggle"[^>]*type="button"[^>]*aria-label="[^"]+"[^>]*aria-pressed="false"/,
  'sound is an accessible native toggle whose static default is OFF',
);

const messageEnd = html.indexOf('</section>', html.indexOf('class="message-window'));
const adStart = html.indexOf('<aside class="ad-reserve"');
const footerStart = html.indexOf('<footer class="site-footer"');
assert.ok(messageEnd >= 0 && adStart > messageEnd && footerStart > adStart,
  'the advertising reservation remains separate from controls and follows the message window');
assert.match(html, /<aside class="ad-reserve"[^>]*aria-label="広告掲載予定領域"/,
  'the advertising reservation remains clearly labelled');

console.log('TASK-012 SEO, accessibility, and advertisement contract test: PASS');
