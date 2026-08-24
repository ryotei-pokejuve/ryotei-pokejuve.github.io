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

  append(...children) { this.children.push(...children); }
  appendChild(child) { this.children.push(child); }
  setAttribute(name, value) { this.attributes[name] = String(value); }
  addEventListener(type, listener) { (this.listeners[type] ||= []).push(listener); }
  dispatch(type, event = {}) {
    for (const listener of this.listeners[type] || []) listener({ target: this, ...event });
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

const documentListeners = {};
const document = {
  activeElement: null,
  documentElement: { dataset: { theme: 'dark' } },
  elements: {},
  createElement(tagName) { return new Element(tagName, this); },
  getElementById(id) { return this.elements[id]; },
  addEventListener(type, listener) { (documentListeners[type] ||= []).push(listener); },
};

for (const id of ['menu-list', 'detail-title', 'detail-content', 'message-text', 'screen-name', 'theme-toggle', 'item-count']) {
  document.elements[id] = new Element('div', document);
}
document.elements['theme-toggle'].append(new Element('span', document));

const mounts = { top: 0, videos: 0 };
const context = {
  document,
  localStorage: { setItem() {} },
  window: {
    location: { href: '' },
    SITE: {
      PAGE_ORDER: ['top', 'videos'],
      PAGES: {
        top: { title: 'TOP', html: '<p>top</p>', onMount() { mounts.top += 1; } },
        videos: { title: 'VIDEOS', html: '<p>videos</p>', onMount() { mounts.videos += 1; } },
      },
    },
  },
};

vm.runInNewContext(fs.readFileSync('assets/js/preview-2d.js', 'utf8'), context);
assert.equal(mounts.top, 1, 'initial selection mounts once');

const buttons = document.elements['menu-list'].querySelectorAll('.menu-item');
buttons[1].click();
assert.equal(mounts.videos, 1, 'focus followed by click mounts once');

let prevented = false;
for (const listener of documentListeners.keydown) {
  listener({
    target: buttons[1], key: 'ArrowLeft', altKey: false, ctrlKey: false, metaKey: false,
    preventDefault() { prevented = true; },
  });
}
assert.equal(mounts.top, 2, 'arrow selection mounts once');
assert.equal(prevented, true, 'handled arrow key prevents its browser default');

for (const listener of documentListeners.keydown) {
  listener({
    target: buttons[0], key: 'ArrowRight', altKey: false, ctrlKey: false, metaKey: false,
    preventDefault() {},
  });
}
assert.equal(mounts.videos, 2, 'arrow selection of an API-backed page mounts once');

console.log('preview-2d selection regression test: PASS');
