const assert = require('node:assert/strict');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const root = path.resolve(__dirname, '..');
const baseRef = process.env.PREVIEW_3D_PROD_BASE_REF;
const protectedFiles = [
  'preview-2d.html',
  'assets/js/preview-2d.js',
  'assets/js/preview-2d-state.js',
  'assets/css/preview-2d.css',
  'assets/css/2d-tokens.css',
  'index.html',
];
const args = ['diff', '--exit-code'];
if (baseRef) args.push(baseRef);
args.push('--', ...protectedFiles);

const result = spawnSync('git', args, {
  cwd: root,
  encoding: 'utf8',
});

assert.equal(result.error, undefined, `git diff could not be executed: ${result.error?.message || ''}`);
assert.equal(
  result.status,
  0,
  [
    `3D host work changed a protected 2D file${baseRef ? ` since ${baseRef}` : ' in the working tree'}`,
    result.stdout,
    result.stderr,
  ].filter(Boolean).join('\n'),
);

console.log('preview-3d no-2D-regression test: PASS');
