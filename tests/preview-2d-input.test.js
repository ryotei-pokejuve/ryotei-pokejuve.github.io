const assert = require('node:assert/strict');
const { isEditing, keydownAction } = require('../assets/js/preview-2d.js');

function target(tagName, options = {}) {
  const classNames = options.classNames || [];
  return {
    isContentEditable: Boolean(options.isContentEditable),
    matches(selector) {
      return selector.split(/,\s*/).some((name) => name.toUpperCase() === tagName.toUpperCase());
    },
    classList: { contains: (name) => classNames.includes(name) },
  };
}

const menuItem = target('button', { classNames: ['menu-item'] });
const plainButton = target('button');

for (const [key, expected] of [
  ['ArrowUp', { type: 'move', delta: -1 }],
  ['ArrowLeft', { type: 'move', delta: -1 }],
  ['ArrowDown', { type: 'move', delta: 1 }],
  ['ArrowRight', { type: 'move', delta: 1 }],
  ['Enter', { type: 'enter' }],
  ['Escape', { type: 'back' }],
]) {
  assert.deepEqual(keydownAction({ key, target: menuItem }), expected, `${key} maps to its shared action`);
}

for (const tagName of ['input', 'textarea', 'select']) {
  const editingTarget = target(tagName);
  assert.equal(isEditing(editingTarget), true, `${tagName} is recognized as an editing target`);
  assert.equal(keydownAction({ key: 'ArrowLeft', target: editingTarget }), null, `${tagName} ignores game keys`);
}

const editable = target('div', { isContentEditable: true });
assert.equal(isEditing(editable), true, 'contenteditable is recognized as an editing target');
assert.equal(keydownAction({ key: 'Escape', target: editable }), null, 'contenteditable ignores game keys');
assert.equal(keydownAction({ key: 'Tab', target: menuItem }), null, 'Tab remains a native browser action');
assert.equal(keydownAction({ key: 'Enter', target: plainButton }), null, 'Enter outside a menu item is not captured');
assert.equal(keydownAction({ key: 'ArrowDown', target: menuItem, altKey: true }), null, 'Alt-modified keys are ignored');
assert.equal(keydownAction({ key: 'ArrowDown', target: menuItem, ctrlKey: true }), null, 'Ctrl-modified keys are ignored');
assert.equal(keydownAction({ key: 'ArrowDown', target: menuItem, metaKey: true }), null, 'Meta-modified keys are ignored');
assert.equal(keydownAction(null), null, 'a missing event is safely ignored');

console.log('preview-2d shared input test: PASS');
