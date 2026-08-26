const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

class Element {
  constructor(tagName, document) {
    this.tagName = tagName.toUpperCase(); this.ownerDocument = document;
    this.children = []; this.listeners = {}; this.attributes = {}; this.className = '';
    this.classList = { contains: (name) => this.className.split(/\s+/).includes(name) };
    this.dataset = {}; this.tabIndex = 0; this.textContent = ''; this.innerHTML = '';
  }
  get firstChild() { return this.children[0] || null; }
  append(...children) { this.children.push(...children); }
  appendChild(child) { this.children.push(child); }
  removeChild(child) { this.children.splice(this.children.indexOf(child), 1); }
  setAttribute(name, value) { this.attributes[name] = String(value); }
  removeAttribute(name) { delete this.attributes[name]; }
  addEventListener(type, listener) { (this.listeners[type] ||= []).push(listener); }
  removeEventListener(type, listener) { this.listeners[type] = (this.listeners[type] || []).filter((item) => item !== listener); }
  dispatch(type) { for (const listener of [...(this.listeners[type] || [])]) listener({ target: this }); }
  click() { this.dispatch('click'); }
  focus() { this.ownerDocument.activeElement = this; this.dispatch('focus'); }
  querySelector(selector) { return selector === 'span' ? this.children[0] : null; }
  querySelectorAll(selector) { return selector === '.menu-item' ? this.children.filter((child) => child.className === 'menu-item') : []; }
}

function createHarness(savedSound, withAudio = true, hash = '') {
  const stored = savedSound === undefined ? {} : { 'ryotei-2d-sound': savedSound };
  let contexts = 0; let oscillators = 0; let closes = 0;
  const document = {
    activeElement: null, documentElement: { dataset: { theme: 'dark' } }, elements: {},
    createElement(tag) { return new Element(tag, this); },
    getElementById(id) { return this.elements[id]; },
    addEventListener() {}, removeEventListener() {},
  };
  for (const id of ['menu-list', 'detail-title', 'detail-code', 'detail-content', 'message-text', 'screen-name', 'status-position', 'status-theme', 'theme-toggle', 'sound-toggle', 'item-count']) {
    document.elements[id] = new Element('div', document);
  }
  document.elements['theme-toggle'].append(new Element('span', document));
  document.elements['sound-toggle'].append(new Element('span', document));
  function AudioContext() {
    contexts += 1; this.currentTime = 0; this.destination = {};
    this.createOscillator = () => ({ type: '', frequency: { value: 0 }, connect() {}, start() { oscillators += 1; }, stop() {} });
    this.createGain = () => ({ connect() {}, gain: { setValueAtTime() {}, exponentialRampToValueAtTime() {} } });
    this.close = () => { closes += 1; };
  }
  const window = {
    location: { pathname: '/index.html', href: `https://example.test/index.html${hash}`, hash },
    history: { pushState() {} }, matchMedia() { return { matches: true }; },
    addEventListener() {}, removeEventListener() {},
    SITE: { PAGE_ORDER: ['top', 'videos'], PAGES: { top: { title: 'TOP', html: '<p>top</p>' }, videos: { title: 'VIDEOS', html: '<p>videos</p>' } } },
  };
  if (withAudio) window.AudioContext = AudioContext;
  const context = {
    window, document,
    localStorage: { getItem(key) { return stored[key] ?? null; }, setItem(key, value) { stored[key] = value; } },
    sessionStorage: { getItem() { return null; } },
    setTimeout() { return 1; }, clearTimeout() {},
  };
  vm.runInNewContext(fs.readFileSync('assets/js/preview-2d-state.js', 'utf8'), context);
  vm.runInNewContext(fs.readFileSync('assets/js/preview-2d.js', 'utf8'), context);
  return { context, document, stored, counts: () => ({ contexts, oscillators, closes }) };
}

const defaultOff = createHarness();
const defaultButton = defaultOff.document.elements['sound-toggle'];
assert.equal(defaultButton.attributes['aria-pressed'], 'false', 'sound defaults to off');
assert.equal(defaultButton.querySelector('span').textContent, 'OFF', 'visible state defaults to OFF');
assert.deepEqual(defaultOff.counts(), { contexts: 0, oscillators: 0, closes: 0 }, 'page load never creates audio');

defaultButton.click();
assert.equal(defaultButton.attributes['aria-pressed'], 'true', 'click exposes the ON state to assistive technology');
assert.equal(defaultButton.querySelector('span').textContent, 'ON', 'click visibly enables sound');
assert.equal(defaultOff.stored['ryotei-2d-sound'], 'on', 'ON state is saved');
assert.deepEqual(defaultOff.counts(), { contexts: 1, oscillators: 1, closes: 0 }, 'first user action creates and plays audio');
defaultButton.click();
assert.equal(defaultOff.stored['ryotei-2d-sound'], 'off', 'OFF state is saved');
assert.equal(defaultOff.counts().oscillators, 1, 'disabling sound does not play audio');
defaultOff.context.window.RYOTEI_RENDERER_2D.unmount();
assert.equal(defaultOff.counts().closes, 1, 'unmount closes the owned audio context');
defaultButton.click();
assert.equal(defaultOff.stored['ryotei-2d-sound'], 'off', 'unmounted toggle has no listener');

const restored = createHarness('on', true, '#top');
assert.equal(restored.document.elements['sound-toggle'].attributes['aria-pressed'], 'true', 'saved ON state is restored');
assert.equal(restored.counts().contexts, 0, 'restoring ON and the initial route still do not create or autoplay audio');
restored.document.elements['menu-list'].querySelectorAll('.menu-item')[1].click();
assert.equal(restored.counts().oscillators, 1, 'a menu pointer activation may play sound after mount');

const unsupported = createHarness('off', false);
assert.doesNotThrow(() => unsupported.document.elements['sound-toggle'].click(), 'missing AudioContext is harmless');
assert.equal(unsupported.document.elements['sound-toggle'].attributes['aria-pressed'], 'true', 'toggle still works without audio support');

const html = fs.readFileSync('index.html', 'utf8');
assert.match(html, /<button id="sound-toggle"[^>]*type="button"[^>]*aria-label="[^"]+"[^>]*aria-pressed="false"/, 'sound control is an accessible native button');
assert.match(html, /SOUND:\s*<span>OFF<\/span>/, 'static markup is visibly OFF without script');

console.log('preview-2d sound test: PASS');
