(function (root, factory) {
  'use strict';

  var api = factory();
  root.RYOTEI_STATE = api;
  if (typeof module === 'object' && module.exports) module.exports = api;
}(typeof window === 'object' ? window : globalThis, function () {
  'use strict';

  var THEMES = ['dark', 'light'];
  var VIEWS = ['2d', '3d'];

  function copyCursor(cursor) {
    return Object.assign({ menu: 0, content: 0, settings: 0 }, cursor || {});
  }

  function createStore(initialState, options) {
    var initial = initialState || {};
    var counts = Object.assign({}, options && options.counts);
    var state = {
      theme: THEMES.indexOf(initial.theme) >= 0 ? initial.theme : 'dark',
      view: VIEWS.indexOf(initial.view) >= 0 ? initial.view : '2d',
      screen: typeof initial.screen === 'string' ? initial.screen : 'menu',
      cursor: copyCursor(initial.cursor),
      message: typeof initial.message === 'string' ? initial.message : '',
    };
    var listeners = [];

    function getState() {
      return Object.assign({}, state, { cursor: copyCursor(state.cursor) });
    }

    function publish(next, action) {
      var previous = state;
      state = next;
      listeners.slice().forEach(function (listener) {
        listener(getState(), Object.assign({}, previous, { cursor: copyCursor(previous.cursor) }), action);
      });
      return getState();
    }

    function update(patch, action) {
      return publish(Object.assign({}, state, patch), action);
    }

    function subscribe(listener) {
      if (typeof listener !== 'function') throw new TypeError('listener must be a function');
      listeners.push(listener);
      return function unsubscribe() {
        var index = listeners.indexOf(listener);
        if (index >= 0) listeners.splice(index, 1);
      };
    }

    function normalizedIndex(index, screenKey) {
      var count = Number(counts[screenKey]);
      if (!Number.isInteger(count) || count <= 0) return state.cursor[screenKey] || 0;
      return ((index % count) + count) % count;
    }

    function select(index, screenKey, message) {
      var key = screenKey || 'menu';
      var cursor = copyCursor(state.cursor);
      cursor[key] = normalizedIndex(index, key);
      return update({ cursor: cursor, screen: 'content', message: typeof message === 'string' ? message : state.message }, 'select');
    }

    function move(delta, screenKey) {
      var key = screenKey || state.screen;
      var cursor = copyCursor(state.cursor);
      cursor[key] = normalizedIndex((cursor[key] || 0) + delta, key);
      return update({ cursor: cursor }, 'move');
    }

    function enter(message) {
      return update({ screen: 'content', message: typeof message === 'string' ? message : state.message }, 'enter');
    }

    function back(message) {
      return update({ screen: 'menu', message: typeof message === 'string' ? message : state.message }, 'back');
    }

    function setMessage(message) {
      return update({ message: typeof message === 'string' ? message : '' }, 'setMessage');
    }

    function setTheme(theme) {
      if (THEMES.indexOf(theme) < 0) return getState();
      return update({ theme: theme }, 'setTheme');
    }

    function setView(view) {
      if (VIEWS.indexOf(view) < 0) return getState();
      return update({ view: view }, 'setView');
    }

    return {
      getState: getState,
      subscribe: subscribe,
      select: select,
      move: move,
      enter: enter,
      back: back,
      setMessage: setMessage,
      setTheme: setTheme,
      setView: setView,
    };
  }

  return { createStore: createStore };
}));
