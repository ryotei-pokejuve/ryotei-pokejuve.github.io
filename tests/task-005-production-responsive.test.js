const assert = require('node:assert/strict');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const ROOT = path.resolve(__dirname, '..');
const viewports = [
  { width: 320, height: 900, label: 'Production 320px', menuColumns: 2, adHeight: 100 },
  { width: 375, height: 900, label: 'Production 375px', menuColumns: 2, adHeight: 100 },
  { width: 390, height: 900, label: 'Production 390px', menuColumns: 2, adHeight: 100 },
  { width: 430, height: 900, label: 'Production 430px', menuColumns: 2, adHeight: 100 },
  { width: 760, height: 900, label: 'Production 760px', menuColumns: 2, adHeight: 90 },
  { width: 1440, height: 900, label: 'Production Desktop 1440px', menuColumns: 1, adHeight: 90 },
];

const browserTest = spawnSync(process.execPath, ['tests/preview-2d-viewport.test.js'], {
  cwd: ROOT,
  env: {
    ...process.env,
    PREVIEW_2D_PAGE_URL: '/index.html',
    PREVIEW_2D_VIEWPORTS: JSON.stringify(viewports),
  },
  encoding: 'utf8',
  timeout: 180_000,
});

assert.equal(
  browserTest.status,
  0,
  [
    'Production index responsive regression must pass at 320/375/390/430/760/Desktop widths.',
    browserTest.stdout,
    browserTest.stderr,
  ].filter(Boolean).join('\n'),
);
assert.match(browserTest.stdout, /preview-2d viewport browser test: PASS/);

console.log('TASK-005 production responsive browser test: PASS');
