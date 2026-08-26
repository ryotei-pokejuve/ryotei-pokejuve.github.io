const assert = require('node:assert/strict');
const fs = require('node:fs');

const html = fs.readFileSync('preview-2d.html', 'utf8');
const css = fs.readFileSync('assets/css/preview-2d.css', 'utf8');

function declaration(selector, property, source) {
  const escapedSelector = selector.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const rule = source.match(new RegExp(`${escapedSelector}\\s*\\{([^}]+)\\}`));
  if (!rule) return null;

  const value = rule[1].match(new RegExp(`(?:^|;)\\s*${property}\\s*:\\s*([^;]+)`));
  return value ? value[1].trim() : null;
}

function mediaBlock(maxWidth) {
  const marker = `@media (max-width: ${maxWidth}px)`;
  const start = css.indexOf(marker);
  assert.notEqual(start, -1, `missing ${marker} breakpoint`);

  const open = css.indexOf('{', start + marker.length);
  let depth = 1;
  let end = open + 1;
  while (depth > 0 && end < css.length) {
    if (css[end] === '{') depth += 1;
    if (css[end] === '}') depth -= 1;
    end += 1;
  }

  assert.equal(depth, 0, `unterminated ${marker} breakpoint`);
  return css.slice(open + 1, end - 1);
}

const responsiveRules = [850, 760, 430].map((maxWidth) => ({
  maxWidth,
  source: mediaBlock(maxWidth),
}));
const baseMinHeight = declaration('.ad-reserve', 'min-height', css);
const mobileMinHeight = declaration('.ad-reserve', 'min-height', responsiveRules[2].source);

assert.match(baseMinHeight || '', /^[1-9]\d*(?:\.\d+)?(?:px|rem|vh)$/, 'the default ad slot reserves non-zero height');
assert.match(mobileMinHeight || '', /^[1-9]\d*(?:\.\d+)?(?:px|rem|vh)$/, 'the mobile ad slot reserves non-zero height');

function effectiveReservedHeight(width) {
  let minHeight = baseMinHeight;
  let height = declaration('.ad-reserve', 'height', css);

  for (const responsiveRule of responsiveRules) {
    if (width > responsiveRule.maxWidth) continue;
    minHeight = declaration('.ad-reserve', 'min-height', responsiveRule.source) || minHeight;
    height = declaration('.ad-reserve', 'height', responsiveRule.source) || height;
  }

  return minHeight || height;
}

const breakpointExpectations = [1280, 850, 760, 430, 390, 375, 320];

for (const width of breakpointExpectations) {
  const reservedHeight = effectiveReservedHeight(width);
  assert.ok(reservedHeight, `.ad-reserve keeps an effective reserved height at ${width}px`);
  assert.ok(parseFloat(reservedHeight) > 0, `.ad-reserve reserved height is non-zero at ${width}px`);
}

assert.match(
  html,
  /<section\s+class="message-window\s+win2"[^>]*>[\s\S]*?<\/section>\s*<aside\s+class="ad-reserve"[^>]*>/,
  'the ad slot is the immediate element after the message window',
);
assert.match(
  html,
  /<aside\s+class="ad-reserve"[^>]*aria-label="広告掲載予定領域"[^>]*>[\s\S]*?ADVERTISEMENT[\s\S]*?<\/aside>/,
  'the reserved slot remains clearly identified as advertising',
);

console.log('preview-2d ad reserve contract test: PASS');
