const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

class Element {
  constructor(tagName, document) {
    this.tagName = tagName.toUpperCase();
    this.ownerDocument = document;
    this.children = [];
    this.listeners = {};
    this.attributes = {};
    this.className = '';
    this.classList = { contains: (name) => this.className.split(/\s+/).includes(name) };
    this.dataset = {};
    this.tabIndex = 0;
    this.textContent = '';
    this.innerHTML = '';
  }

  get firstChild() { return this.children[0] || null; }
  append(...children) { this.children.push(...children); }
  appendChild(child) { this.children.push(child); }
  removeChild(child) {
    const index = this.children.indexOf(child);
    if (index >= 0) this.children.splice(index, 1);
    return child;
  }
  setAttribute(name, value) { this.attributes[name] = String(value); }
  removeAttribute(name) { delete this.attributes[name]; }
  addEventListener(type, listener) { (this.listeners[type] ||= []).push(listener); }
  removeEventListener(type, listener) {
    const listeners = this.listeners[type] || [];
    const index = listeners.indexOf(listener);
    if (index >= 0) listeners.splice(index, 1);
  }
  dispatch(type, event = {}) {
    for (const listener of [...(this.listeners[type] || [])]) listener({ target: this, ...event });
  }
  matches(selector) {
    return selector.split(/,\s*/).some((name) => name.toUpperCase() === this.tagName);
  }
  focus() {
    if (this.ownerDocument.activeElement === this) return;
    this.ownerDocument.activeElement = this;
    this.dispatch('focus');
  }
  click() {
    this.focus();
    this.dispatch('click');
  }
  querySelector(selector) { return selector === 'span' ? this.children[0] : null; }
  querySelectorAll(selector) {
    return selector === '.menu-item' ? this.children.filter((child) => child.className === 'menu-item') : [];
  }
}

function createHarness(pathname) {
  const documentListeners = {};
  const windowListeners = {};
  const pendingTimers = new Map();
  const storedValues = {};
  let nextTimerId = 1;

  const document = {
    activeElement: null,
    documentElement: { dataset: { theme: 'dark' } },
    elements: {},
    createElement(tagName) { return new Element(tagName, this); },
    getElementById(id) { return this.elements[id]; },
    addEventListener(type, listener) { (documentListeners[type] ||= []).push(listener); },
    removeEventListener(type, listener) {
      const listeners = documentListeners[type] || [];
      const index = listeners.indexOf(listener);
      if (index >= 0) listeners.splice(index, 1);
    },
  };

  for (const id of ['menu-list', 'detail-title', 'detail-code', 'detail-content', 'message-text', 'screen-name', 'status-position', 'status-theme', 'theme-toggle', 'item-count']) {
    document.elements[id] = new Element('div', document);
  }
  document.elements['theme-toggle'].append(new Element('span', document));

  const location = { pathname, href: `https://example.test${pathname}`, hash: '' };
  const window = {
    location,
    history: { pushState() {} },
    matchMedia() { return { matches: false }; },
    addEventListener(type, listener) { (windowListeners[type] ||= []).push(listener); },
    removeEventListener(type, listener) {
      const listeners = windowListeners[type] || [];
      const index = listeners.indexOf(listener);
      if (index >= 0) listeners.splice(index, 1);
    },
    SITE: {
      PAGE_ORDER: ['top', 'videos'],
      PAGES: {
        top: { title: 'TOP', html: '<p>top</p>' },
        videos: { title: 'VIDEOS', html: '<p>videos</p>' },
      },
    },
  };

  const context = {
    document,
    window,
    localStorage: { setItem(key, value) { storedValues[key] = value; } },
    setTimeout(callback) {
      const id = nextTimerId++;
      pendingTimers.set(id, callback);
      return id;
    },
    clearTimeout(id) { pendingTimers.delete(id); },
  };

  vm.runInNewContext(fs.readFileSync('assets/js/preview-2d-state.js', 'utf8'), context);
  vm.runInNewContext(fs.readFileSync('assets/js/preview-2d.js', 'utf8'), context);
  return { context, document, documentListeners, pendingTimers, storedValues, windowListeners };
}

const previewHarness = createHarness('/preview-2d.html');
const renderer = previewHarness.context.window.RYOTEI_RENDERER_2D;
assert.equal(typeof renderer.mount, 'function', 'renderer exposes mount()');
assert.equal(typeof renderer.unmount, 'function', 'renderer exposes unmount()');
assert.equal(previewHarness.documentListeners.keydown.length, 1, 'automatic mount registers one keydown listener');

const existingInstance = renderer.mount(previewHarness.document);
assert.equal(renderer.mount(previewHarness.document), existingInstance, 'mount is idempotent while active');
assert.equal(previewHarness.documentListeners.keydown.length, 1, 'idempotent mount does not duplicate keydown listeners');

const themeBeforeUnmount = previewHarness.document.documentElement.dataset.theme;
const storedThemeBeforeUnmount = previewHarness.storedValues['ryotei-2d-theme'];
const staleTimer = previewHarness.pendingTimers.values().next().value;
assert.equal(typeof staleTimer, 'function', 'automatic render starts the message timer');
renderer.unmount();
assert.equal(previewHarness.documentListeners.keydown.length, 0, 'unmount removes the keydown listener');
assert.equal(previewHarness.document.elements['menu-list'].querySelectorAll('.menu-item').length, 0, 'unmount removes menu items');

previewHarness.document.elements['theme-toggle'].click();
assert.equal(previewHarness.document.documentElement.dataset.theme, themeBeforeUnmount, 'detached theme toggle cannot change the theme');
assert.equal(previewHarness.storedValues['ryotei-2d-theme'], storedThemeBeforeUnmount, 'detached theme toggle cannot write localStorage');

const messageAfterUnmount = previewHarness.document.elements['message-text'].textContent;
staleTimer();
assert.equal(previewHarness.document.elements['message-text'].textContent, messageAfterUnmount, 'cleared message callback cannot write after unmount');
assert.doesNotThrow(() => renderer.unmount(), 'unmount is idempotent');

renderer.mount(previewHarness.document);
assert.equal(previewHarness.documentListeners.keydown.length, 1, 'remount registers exactly one keydown listener');

const productionHarness = createHarness('/index.html');
assert.equal(productionHarness.windowListeners.popstate.length, 1, 'production automatic mount registers one popstate listener');
productionHarness.context.window.RYOTEI_RENDERER_2D.unmount();
assert.equal(productionHarness.windowListeners.popstate.length, 0, 'unmount removes the popstate listener');

console.log('preview-2d lifecycle test: PASS');
