const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const repositoryRoot = path.resolve(__dirname, '..');
const scanRoot = process.env.THIRD_PARTY_ASSET_SCAN_ROOT
  ? path.resolve(process.env.THIRD_PARTY_ASSET_SCAN_ROOT)
  : repositoryRoot;

const productionSources = [
  'preview-2d.html',
  'assets/css/preview-2d.css',
  'assets/js/preview-2d.js',
  'content.js',
];

const referenceAssetDirectory = path.join(repositoryRoot, 'docs', 'design', '2d', 'uploads');
const referenceAssetNames = fs.readdirSync(referenceAssetDirectory, { withFileTypes: true })
  .filter((entry) => entry.isFile())
  .map((entry) => entry.name);

const forbiddenPathPattern = /(?:docs[\\/]design|uploads[\\/])/i;

for (const relativeFile of productionSources) {
  const source = fs.readFileSync(path.join(scanRoot, relativeFile), 'utf8');

  assert.doesNotMatch(
    source,
    forbiddenPathPattern,
    `${relativeFile} must not reference Design documents or uploaded reference assets`,
  );

  for (const assetName of referenceAssetNames) {
    assert.equal(
      source.toLowerCase().includes(assetName.toLowerCase()),
      false,
      `${relativeFile} must not reference third-party reference asset ${assetName}`,
    );
  }
}

console.log('no third-party reference assets test: PASS');
