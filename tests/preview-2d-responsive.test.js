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

const tabletMedia = mediaBlock('@media (max-width: 760px)', '@media (max-width: 430px)');
assert.match(
  tabletMedia,
  /\.menu-list\s*\{[^}]*grid-template-columns:\s*repeat\(2,\s*minmax\(0,\s*1fr\)\)/,
  'the compact menu keeps two shrinkable columns',
);

const mobileMedia = mediaBlock('@media (max-width: 430px)', '@media (prefers-reduced-motion: reduce)');
assert.match(rule('.menu-item', mobileMedia), /min-height:\s*48px/, 'mobile menu items exceed 44px');
assert.match(rule('#theme-toggle'), /min-height:\s*44px/, 'the theme control meets the touch target minimum');
assert.match(rule('.open-link'), /min-height:\s*44px/, 'external actions meet the touch target minimum');

const adRule = rule('.ad-reserve');
assert.match(adRule, /min-height:\s*90px/, 'the desktop/tablet ad slot reserves height');
assert.doesNotMatch(adRule, /position:\s*(?:absolute|fixed|sticky)/, 'the ad slot stays in normal flow');
assert.match(rule('.ad-reserve', mobileMedia), /min-height:\s*100px/, 'the mobile ad slot reserves height');
assert.ok(
  html.indexOf('class="message-window') < html.indexOf('class="ad-reserve'),
  'the reserved ad slot remains directly after the message area',
);

console.log('preview-2d responsive contract test: PASS');
