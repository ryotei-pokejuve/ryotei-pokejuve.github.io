const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..');
const buildDirectory = path.join(root, 'assets', '3d', 'unity', 'Build');
const expectedFiles = [
  'WebGL.loader.js',
  'WebGL.data.unityweb',
  'WebGL.framework.js.unityweb',
  'WebGL.wasm.unityweb',
];

assert.deepEqual(
  fs.readdirSync(buildDirectory).sort(),
  [...expectedFiles].sort(),
  'Unity Build directory contains exactly the four approved artifacts',
);

for (const fileName of expectedFiles) {
  const filePath = path.join(buildDirectory, fileName);
  assert.ok(fs.existsSync(filePath), `${fileName} exists`);
  assert.ok(fs.statSync(filePath).size > 0, `${fileName} is not empty`);
}

assert.deepEqual(
  expectedFiles.filter((fileName) => fileName !== 'WebGL.loader.js').map((fileName) => path.extname(fileName)),
  ['.unityweb', '.unityweb', '.unityweb'],
  'Unity data, framework, and WebAssembly artifacts retain the decompression-fallback extension',
);

const host = fs.readFileSync(path.join(root, 'assets', 'js', 'preview-3d-host.js'), 'utf8');
assert.match(host, /const BUILD_URL = 'assets\/3d\/unity\/Build';/, 'host uses the relative Unity build directory');
for (const fileName of expectedFiles) {
  if (fileName === 'WebGL.loader.js') {
    assert.match(host, /const LOADER_URL = 'assets\/3d\/unity\/Build\/WebGL\.loader\.js';/);
  } else {
    assert.ok(host.includes(`/${fileName}\``), `host config references ${fileName}`);
  }
}

const buildInfoPath = path.join(root, 'assets', '3d', 'unity', 'BUILD_INFO.md');
assert.ok(fs.existsSync(buildInfoPath), 'BUILD_INFO.md exists');
const buildInfo = fs.readFileSync(buildInfoPath, 'utf8');
assert.match(buildInfo, /Unity version: `6000\.3\.23f1`/, 'Unity version is recorded');
assert.match(buildInfo, /Unity repository commit: `fef3926`/, 'Unity source commit is recorded');
assert.match(buildInfo, /Decompression Fallback: \*\*ON\*\*/, 'decompression fallback is recorded as enabled');
assert.match(buildInfo, /must not be disabled/i, 'decompression fallback warning is recorded');
assert.match(buildInfo, /StreamingAssets is not used|`StreamingAssets` is not used/, 'unused StreamingAssets is recorded');

for (const fileName of expectedFiles) {
  const filePath = path.join(buildDirectory, fileName);
  const size = fs.statSync(filePath).size;
  const digest = crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex').toUpperCase();
  assert.ok(
    buildInfo.includes(`| \`Build/${fileName}\` | ${size} | \`${digest}\` |`),
    `${fileName} size and hash are recorded`,
  );
}

const attributes = fs.readFileSync(path.join(root, '.gitattributes'), 'utf8');
for (const rule of ['*.unityweb binary', '*.wasm     binary', '*.data     binary']) {
  assert.ok(attributes.includes(rule), `.gitattributes contains ${rule}`);
}

console.log('preview-3d asset layout test: PASS');
