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

const finalizedFeatureSources = [
  'index.html',
  'assets/js/preview-2d.js',
  'assets/css/preview-2d.css',
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

const audioElementPattern = /<audio\b/i;
const audioAssetPattern = /(?:^|["'`()\s:/\\])[^"'`()\s]*\.(?:aac|flac|m4a|mp3|oga|ogg|opus|wav|webm)(?:[?#][^"'`()\s]*)?(?=$|["'`()\s])/i;
const externalImagePattern = /(?:https?:)?\/\/[^\s"')]+\.(?:avif|bmp|gif|jpe?g|png|svg|webp)(?:[?#][^\s"')]*)?/i;
const suspiciousGameAssetPathPattern = /(?:^|["'`()\s:/\\])(?:assets[\\/])?(?:audio|game-assets?|third-party-assets?|roms?|sprites?|gba|gameboy|nintendo|pokemon)[\\/]/i;

for (const relativeFile of finalizedFeatureSources) {
  const source = fs.readFileSync(path.join(scanRoot, relativeFile), 'utf8');

  assert.doesNotMatch(source, audioElementPattern, `${relativeFile} must not embed audio elements`);
  assert.doesNotMatch(source, audioAssetPattern, `${relativeFile} must not reference audio files`);
  assert.doesNotMatch(source, externalImagePattern, `${relativeFile} must not reference external images`);
  assert.doesNotMatch(
    source,
    suspiciousGameAssetPathPattern,
    `${relativeFile} must not reference game, ROM, sprite, or audio asset directories`,
  );
}

const rendererSource = fs.readFileSync(
  path.join(scanRoot, 'assets/js/preview-2d.js'),
  'utf8',
);
assert.match(
  rendererSource,
  /window\.(?:AudioContext|webkitAudioContext)/,
  'sound feedback must use the Web Audio API',
);
assert.match(
  rendererSource,
  /\.createOscillator\s*\(/,
  'sound feedback must be synthesized with an oscillator',
);

const previewStyles = fs.readFileSync(
  path.join(scanRoot, 'assets/css/preview-2d.css'),
  'utf8',
);
assert.doesNotMatch(
  previewStyles,
  /url\s*\(/i,
  '2D Preview effects must remain CSS-only and must not load image assets',
);

console.log('no third-party assets test: PASS');
