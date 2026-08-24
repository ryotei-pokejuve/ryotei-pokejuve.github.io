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
  removeAttribute(name) { delete this.attributes[name]; }
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

for (const id of ['menu-list', 'detail-title', 'detail-code', 'detail-content', 'message-text', 'screen-name', 'status-position', 'status-theme', 'theme-toggle', 'item-count']) {
  document.elements[id] = new Element('div', document);
}
document.elements['theme-toggle'].append(new Element('span', document));

const mounts = { top: 0, videos: 0 };
const navigations = [];
const storedValues = {};
const location = {
  _href: '',
  get href() { return this._href; },
  set href(value) {
    this._href = value;
    navigations.push({ href: value, message: document.elements['message-text'].textContent });
  },
};
const context = {
  document,
  localStorage: { setItem(key, value) { storedValues[key] = value; } },
  window: {
    location,
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
assert.match(
  document.elements['message-text'].textContent,
  /^TOP/,
  'missing matchMedia falls back to the complete message without timers',
);
assert.equal(storedValues['ryotei-2d-theme'], 'dark', 'initial theme is persisted');

document.elements['theme-toggle'].click();
assert.equal(document.documentElement.dataset.theme, 'light', 'theme toggle applies the light theme');
assert.equal(storedValues['ryotei-2d-theme'], 'light', 'theme toggle persists the light theme');
assert.equal(document.elements['theme-toggle'].attributes['aria-pressed'], 'true', 'light theme is exposed to assistive technology');
assert.equal(document.elements['theme-toggle'].querySelector('span').textContent, 'LIGHT', 'theme label follows the selected theme');
assert.equal(document.elements['status-theme'].textContent, 'LIGHT', 'HUD theme readout follows the selected theme');

document.elements['theme-toggle'].click();
assert.equal(document.documentElement.dataset.theme, 'dark', 'second theme toggle restores the dark theme');
assert.equal(storedValues['ryotei-2d-theme'], 'dark', 'second theme toggle persists the dark theme');

const buttons = document.elements['menu-list'].querySelectorAll('.menu-item');
assert.equal(document.elements['status-position'].textContent, '01/03', 'HUD cursor starts at the first menu item');
assert.equal(buttons[0].attributes['aria-selected'], 'true', 'initial cursor has one selected menu item');
assert.equal(
  buttons.filter((button) => button.attributes['aria-selected'] === 'true').length,
  1,
  'initial render never paints two selected rows',
);
buttons[1].click();
assert.equal(mounts.videos, 1, 'focus followed by click mounts once');
assert.equal(document.elements['screen-name'].textContent, 'VIDEOS', 'HUD screen readout follows the selected content');
assert.equal(document.elements['detail-code'].textContent, 'DATA / VIDEOS', 'content title plate identifies the selected data file');
assert.equal(document.elements['status-position'].textContent, '02/03', 'HUD cursor follows mouse selection');

for (const target of [
  new Element('input', document),
  new Element('textarea', document),
  new Element('select', document),
  Object.assign(new Element('div', document), { isContentEditable: true }),
]) {
  let editingPrevented = false;
  for (const listener of documentListeners.keydown) {
    listener({
      target, key: 'ArrowLeft', altKey: false, ctrlKey: false, metaKey: false,
      preventDefault() { editingPrevented = true; },
    });
  }
  assert.equal(mounts.top, 1, `${target.tagName} keydown does not change the selection`);
  assert.equal(editingPrevented, false, `${target.tagName} keydown keeps its browser default`);
}

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

for (const listener of documentListeners.keydown) {
  listener({
    target: buttons[1], key: 'Escape', altKey: false, ctrlKey: false, metaKey: false,
    preventDefault() {},
  });
}
assert.equal(document.activeElement, document.elements['menu-list'], 'Escape focuses the menu container');
assert.equal(document.elements['menu-list'].tabIndex, 0, 'Escape restores the menu container tab stop');
assert.equal(document.elements['screen-name'].textContent, 'MENU', 'Escape restores the menu screen name');
assert.equal(document.elements['detail-title'].textContent, 'MENU', 'Escape restores the menu detail title');
assert.equal(document.elements['detail-code'].textContent, 'DATA / --', 'Escape clears the content title plate');
assert.equal(
  document.elements['detail-content'].textContent,
  '方向キーまたはタッチで項目を選択してください。',
  'Escape replaces stale detail content with the menu empty state',
);
assert.equal(
  document.elements['message-text'].textContent,
  'メニューへ戻りました。方向キーまたはタッチで項目を選択できます。',
  'Escape message matches the restored menu screen',
);
assert.equal(
  buttons.every((button) => button.attributes['aria-selected'] === 'false' && button.tabIndex === -1),
  true,
  'Escape leaves the menu container as the only menu tab stop',
);
assert.equal(
  document.elements['menu-list'].attributes['aria-activedescendant'],
  undefined,
  'Escape clears the active descendant while no item is selected',
);

for (const listener of documentListeners.keydown) {
  listener({
    target: document.elements['menu-list'], key: 'ArrowRight', altKey: false, ctrlKey: false, metaKey: false,
    preventDefault() {},
  });
}
assert.equal(buttons[2].attributes['aria-selected'], 'true', 'selection resumes from the remembered cursor after Escape');
assert.equal(buttons[2].tabIndex, 0, 'resumed selection restores one item tab stop');
assert.equal(document.elements['menu-list'].tabIndex, -1, 'active item replaces the menu container tab stop');
assert.equal(document.activeElement, buttons[2], 'resumed keyboard selection focuses the selected item');

for (const listener of documentListeners.keydown) {
  listener({
    target: buttons[2], key: 'ArrowRight', altKey: false, ctrlKey: false, metaKey: false,
    preventDefault() {},
  });
}
assert.equal(buttons[0].attributes['aria-selected'], 'true', 'forward arrow navigation wraps from the last item to the first');
assert.equal(mounts.top, 3, 'wrapped selection renders the destination once');

for (const listener of documentListeners.keydown) {
  listener({
    target: buttons[0], key: 'ArrowLeft', altKey: false, ctrlKey: false, metaKey: false,
    preventDefault() {},
  });
}
assert.equal(buttons[2].attributes['aria-selected'], 'true', 'backward arrow navigation wraps to CARD MARKET');
assert.equal(
  buttons.filter((button) => button.attributes['aria-selected'] === 'true').length,
  1,
  'wrapped keyboard navigation keeps a single selected row',
);

for (const listener of documentListeners.keydown) {
  listener({
    target: buttons[2], key: 'Enter', altKey: false, ctrlKey: false, metaKey: false,
    preventDefault() {},
  });
}
assert.equal(location.href, 'search.html', 'keyboard Enter opens the external destination');
assert.match(navigations.at(-1).message, /^CARD MARKET/, 'keyboard navigation occurs after the external preview message');

location._href = '';
buttons[2].click();
assert.equal(location.href, 'search.html', 'mouse click opens the same external destination');
assert.equal(document.elements['detail-code'].textContent, 'LINK / MARKET', 'external content uses the link title plate');
assert.match(navigations.at(-1).message, /^CARD MARKET/, 'mouse navigation occurs after the same external preview message');

location._href = '';
buttons[2].dispatch('click', { pointerType: 'touch' });
assert.equal(location.href, 'search.html', 'touch-generated click opens the same external destination');
assert.match(navigations.at(-1).message, /^CARD MARKET/, 'touch navigation occurs after the same external preview message');

console.log('preview-2d selection regression test: PASS');
