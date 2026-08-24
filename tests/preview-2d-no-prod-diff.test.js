const assert = require('node:assert/strict');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const repositoryRoot = path.resolve(__dirname, '..');
const baseRef = process.env.PREVIEW_2D_PROD_BASE_REF;
const productionFiles = [
  'lain.html',
  'content.js',
  'about.html',
  'privacy.html',
  'terms.html',
  'contact.html',
  'search.html',
  'card.html',
  'admin.html',
  'admin.js',
  'market.js',
];

const args = ['diff', '--exit-code'];
if (baseRef) args.push(baseRef);
args.push('--', ...productionFiles);

const result = spawnSync('git', args, {
  cwd: repositoryRoot,
  encoding: 'utf8',
});

assert.equal(
  result.error,
  undefined,
  `git diff could not be executed: ${result.error ? result.error.message : ''}`,
);
assert.equal(
  result.status,
  0,
  [
    `production files differ${baseRef ? ` from ${baseRef}` : ' in the working tree'}`,
    result.stdout,
    result.stderr,
  ].filter(Boolean).join('\n'),
);

console.log('preview-2d production file diff guard test: PASS');

const approvedResult = spawnSync('git', ['diff', '--name-only', ...(baseRef ? [baseRef] : []), '--', 'index.html'], { cwd: repositoryRoot, encoding: 'utf8' });
assert.equal(approvedResult.error, undefined, 'approved production diff could not be inspected');
assert.equal(approvedResult.status, 0, approvedResult.stderr);
assert.ok(
  approvedResult.stdout.trim().split(/\r?\n/).filter(Boolean).every((file) => file === 'index.html'),
  'TASK-007 approval is scoped to index.html',
);
