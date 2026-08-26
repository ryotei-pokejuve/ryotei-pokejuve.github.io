const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const ROOT = path.resolve(__dirname, '..');
const RUNNER_FILE = path.basename(__filename);
const checks = fs.readdirSync(__dirname, { withFileTypes: true })
  .filter((entry) => entry.isFile()
    && entry.name.endsWith('.test.js')
    && entry.name !== RUNNER_FILE)
  .map((entry) => entry.name)
  .sort((left, right) => left.localeCompare(right, 'en'))
  .map((fileName) => [fileName, path.join('tests', fileName)]);

const results = [];

for (const [label, testFile] of checks) {
  console.log(`\n=== ${label} ===`);
  const result = spawnSync(process.execPath, [testFile], {
    cwd: ROOT,
    encoding: 'utf8',
    env: process.env,
    timeout: 240_000,
  });

  if (result.stdout) process.stdout.write(result.stdout);
  if (result.stderr) process.stderr.write(result.stderr);

  const passed = result.status === 0 && result.error === undefined;
  results.push({ label, testFile, passed, result });
  console.log(`${passed ? 'PASS' : 'FAIL'}: ${label}`);
}

console.log('\n=== 2D MODE FINAL QA SUMMARY ===');
for (const { label, testFile, passed } of results) {
  console.log(`${passed ? 'PASS' : 'FAIL'}  ${label} (${testFile})`);
}

const failures = results.filter(({ passed }) => !passed);
console.log(`\n${results.length - failures.length}/${results.length} checks passed.`);

if (failures.length > 0) {
  for (const { label, result } of failures) {
    if (result.error) console.error(`${label}: ${result.error.message}`);
    else if (result.signal) console.error(`${label}: terminated by ${result.signal}`);
    else console.error(`${label}: exited with status ${result.status}`);
  }
  process.exitCode = 1;
}
