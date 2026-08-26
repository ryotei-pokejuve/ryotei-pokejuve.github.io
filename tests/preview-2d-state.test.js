const assert = require('node:assert/strict');
const { createStore } = require('../assets/js/preview-2d-state.js');

const store = createStore({
  theme: 'dark',
  view: '2d',
  screen: 'menu',
  cursor: { menu: 0, content: 1, settings: 2 },
  message: '',
}, { counts: { menu: 3, content: 4, settings: 5 } });

const notifications = [];
const unsubscribe = store.subscribe((state, previous, action) => notifications.push({ state, previous, action }));

store.move(-1);
assert.equal(store.getState().cursor.menu, 2, 'move wraps backward within the active screen');
store.move(1);
assert.equal(store.getState().cursor.menu, 0, 'move wraps forward within the active screen');

store.select(2, 'menu', 'selected');
assert.equal(store.getState().screen, 'content', 'select opens the content screen');
assert.equal(store.getState().cursor.menu, 2, 'select records the menu cursor');
store.move(2, 'content');
assert.equal(store.getState().cursor.content, 3, 'another screen cursor moves independently');
assert.equal(store.getState().cursor.menu, 2, 'moving another screen preserves the menu cursor');

store.back('back');
assert.equal(store.getState().screen, 'menu', 'back returns to the menu');
assert.equal(store.getState().cursor.menu, 2, 'back preserves the remembered menu cursor');
store.enter('open');
assert.equal(store.getState().screen, 'content', 'enter opens content without DOM involvement');

store.setTheme('light');
store.setTheme('sepia');
assert.equal(store.getState().theme, 'light', 'setTheme rejects unknown values');
store.setView('3d');
store.setView('vr');
assert.equal(store.getState().view, '3d', 'setView rejects unknown values');

const snapshot = store.getState();
snapshot.cursor.menu = 99;
assert.equal(store.getState().cursor.menu, 2, 'getState does not expose mutable cursor state');
assert.ok(notifications.length >= 8, 'subscribers receive state transitions');
assert.equal(notifications.at(-1).action, 'setView', 'notifications identify the accepted action');
unsubscribe();
const countAfterUnsubscribe = notifications.length;
store.setView('2d');
assert.equal(notifications.length, countAfterUnsubscribe, 'unsubscribe stops notifications');

console.log('preview-2d common state test: PASS');
