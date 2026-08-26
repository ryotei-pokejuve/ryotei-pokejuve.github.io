const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const ROOT = path.resolve(__dirname, '..');
const pageUrl = '/index.html?view=3d';
const html = fs.readFileSync(path.join(ROOT, 'index.html'), 'utf8');

for (const selector of [
  'id="menu-list"',
  'class="detail-pane"',
  'class="message-window win2"',
]) {
  assert.ok(html.includes(selector), `${selector} remains in the production 2D shell`);
}

const browserTest = spawnSync(process.execPath, ['tests/preview-2d-viewport.test.js'], {
  cwd: ROOT,
  env: { ...process.env, PREVIEW_2D_PAGE_URL: pageUrl },
  encoding: 'utf8',
  timeout: 120_000,
});

assert.equal(
  browserTest.status,
  0,
  [
    `${pageUrl} must render the production 2D shell without console errors or uncaught exceptions`,
    'and keep its menu reachable by keyboard.',
    browserTest.stdout,
    browserTest.stderr,
  ].filter(Boolean).join('\n'),
);
assert.match(browserTest.stdout, /preview-2d viewport browser test: PASS/);

console.log('TASK-004 production 3D URL fallback browser test: PASS');
