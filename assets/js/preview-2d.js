(function (root, factory) {
  'use strict';

  var shared = factory();
  root.RYOTEI_CONTENT_ADAPTER = { createEntities: shared.createEntities };
  root.RYOTEI_INPUT = {
    isEditing: shared.isEditing,
    keydownAction: shared.keydownAction,
  };
  root.RYOTEI_NAVIGATION = { resolveView: shared.resolveView, resolveRoute: shared.resolveRoute };
  if (typeof module === 'object' && module.exports) module.exports = shared;
}(typeof window === 'object' ? window : globalThis, function () {
  'use strict';

  function createEntities(pages, order) {
    var pageMap = pages || {};
    var pageOrder = Array.isArray(order) ? order : [];
    var entities = pageOrder.filter(function (id) { return pageMap[id]; }).map(function (id) {
      return { id: id, title: pageMap[id].title || id, kind: 'content', href: null, page: pageMap[id] };
    });

    entities.push({ id: 'market', title: 'CARD MARKET', kind: 'external', href: 'search.html', page: null });
    return entities;
  }

  function isEditing(target) {
    return Boolean(target && (
      (typeof target.matches === 'function' && target.matches('input, textarea, select'))
      || target.isContentEditable
    ));
  }

  function isMenuItem(target) {
    return Boolean(target && target.classList && target.classList.contains('menu-item'));
  }

  function keydownAction(event) {
    if (!event || isEditing(event.target) || event.altKey || event.ctrlKey || event.metaKey) return null;
    if (event.key === 'ArrowUp' || event.key === 'ArrowLeft') return { type: 'move', delta: -1 };
    if (event.key === 'ArrowDown' || event.key === 'ArrowRight') return { type: 'move', delta: 1 };
    if (event.key === 'Enter' && isMenuItem(event.target)) return { type: 'enter' };
    if (event.key === 'Escape') return { type: 'back' };
    return null;
  }

  function resolveView(url) {
    try {
      // Read the future renderer preference without enabling an unavailable view.
      // URL also keeps the existing hash intact because this adapter never writes it.
      var requestedView = new URL(String(url || ''), 'https://preview.invalid/').searchParams.get('view');
      if (requestedView === '2d') return requestedView;
    } catch (error) {}
    return '2d';
  }

  function resolveRoute(url, pages) {
    try {
      var key = new URL(String(url || ''), 'https://preview.invalid/').hash.slice(1);
      return pages && pages[key] ? key : null;
    } catch (error) {}
    return null;
  }

  return {
    createEntities: createEntities,
    isEditing: isEditing,
    keydownAction: keydownAction,
    resolveView: resolveView,
    resolveRoute: resolveRoute,
  };
}));

(function () {
  'use strict';

  if (typeof window !== 'object') return;

  var THEME_KEY = 'ryotei-2d-theme';
  var pages = null;
  var order = null;
  var menu = [];
  var store = null;
  var menuList = null;
  var detailTitle = null;
  var detailCode = null;
  var detailContent = null;
  var messageText = null;
  var screenName = null;
  var statusPosition = null;
  var statusTheme = null;
  var themeToggle = null;
  var isSelecting = false;
  var messageTimer = null;
  var messageRun = 0;
  var isProductionTop = false;
  var activeInstance = null;
  var disposers = [];

  function finishMessage() {
    messageRun += 1;
    if (messageTimer !== null && typeof clearTimeout === 'function') clearTimeout(messageTimer);
    messageTimer = null;
    messageText.textContent = store.getState().message;
  }

  function setMessage(message) {
    store.setMessage(message);
    finishMessage();

    var canAnimate = typeof window.matchMedia === 'function'
      && !window.matchMedia('(prefers-reduced-motion: reduce)').matches
      && typeof setTimeout === 'function';
    if (!canAnimate || !message) return;

    var run = messageRun;
    var position = 0;
    messageText.textContent = '';

    function typeNextCharacter() {
      if (run !== messageRun) return;
      position += 1;
      messageText.textContent = message.slice(0, position);
      if (position < message.length) {
        messageTimer = setTimeout(typeNextCharacter, 20);
      } else {
        messageTimer = null;
      }
    }

    typeNextCharacter();
  }

  function pageHtml(page) {
    return typeof page.html === 'function' ? page.html() : (page.html || '');
  }

  function plainSummary(item) {
    if (item.kind === 'external') return 'カードを検索し、価格情報を確認する既存ページを開きます。';
    var scratch = document.createElement('div');
    scratch.innerHTML = pageHtml(item.page);
    var text = (scratch.textContent || '').replace(/\s+/g, ' ').trim();
    return text ? text.slice(0, 110) : item.title + ' の情報を表示します。';
  }

  function deriveMessage(item) {
    return item.title + '：' + plainSummary(item);
  }

  function setTheme(theme) {
    store.setTheme(theme);
    theme = store.getState().theme;
    document.documentElement.dataset.theme = theme;
    themeToggle.querySelector('span').textContent = theme.toUpperCase();
    statusTheme.textContent = theme.toUpperCase();
    themeToggle.setAttribute('aria-pressed', String(theme === 'light'));
    try { localStorage.setItem(THEME_KEY, theme); } catch (error) {}
  }

  function renderDetail(item) {
    detailTitle.textContent = item.title;
    detailCode.textContent = (item.kind === 'external' ? 'LINK' : 'DATA') + ' / ' + item.id.toUpperCase();
    screenName.textContent = item.kind === 'external' ? 'LINK' : item.id.toUpperCase();
    if (item.kind === 'external') {
      detailContent.innerHTML = '';
      var box = document.createElement('div');
      box.className = 'external-card';
      var label = document.createElement('p');
      label.className = 'panel-label';
      label.textContent = 'EXTERNAL DATABASE';
      var description = document.createElement('p');
      description.textContent = plainSummary(item);
      var link = document.createElement('a');
      link.className = 'open-link';
      link.href = item.href;
      link.textContent = 'カード相場を開く';
      box.append(label, description, link);
      detailContent.appendChild(box);
    } else {
      detailContent.innerHTML = '<div class="page-content" id="page-content">' + pageHtml(item.page) + '</div>';
      if (typeof item.page.onMount === 'function') item.page.onMount();
    }
  }

  function updateStatusPosition() {
    var cursor = store.getState().cursor.menu;
    statusPosition.textContent = String(cursor + 1).padStart(2, '0') + '/' + String(menu.length).padStart(2, '0');
  }

  function resetToMenu(focusMenu) {
    store.back('メニューへ戻りました。方向キーまたはタッチで項目を選択できます。');
    menuList.tabIndex = 0;
    var buttons = menuList.querySelectorAll('.menu-item');
    buttons.forEach(function (button) {
      button.setAttribute('aria-selected', 'false');
      button.tabIndex = -1;
    });
    menuList.removeAttribute('aria-activedescendant');
    detailTitle.textContent = 'MENU';
    detailCode.textContent = 'DATA / --';
    detailContent.textContent = '方向キーまたはタッチで項目を選択してください。';
    screenName.textContent = 'MENU';
    updateStatusPosition();
    setMessage('メニューへ戻りました。方向キーまたはタッチで項目を選択できます。');
    if (focusMenu !== false) menuList.focus();
  }

  function select(index, focusItem) {
    if (!menu.length || isSelecting) return;
    var nextCursor = (index + menu.length) % menu.length;
    var state = store.getState();
    if (state.screen === 'content' && nextCursor === state.cursor.menu) {
      if (focusItem) menuList.querySelectorAll('.menu-item')[nextCursor].focus();
      return;
    }
    isSelecting = true;
    try {
      store.select(nextCursor, 'menu', deriveMessage(menu[nextCursor]));
      state = store.getState();
      var buttons = menuList.querySelectorAll('.menu-item');
      menuList.tabIndex = -1;
      buttons.forEach(function (button, buttonIndex) {
        var selected = buttonIndex === state.cursor.menu;
        button.setAttribute('aria-selected', String(selected));
        button.tabIndex = selected ? 0 : -1;
      });
      menuList.setAttribute('aria-activedescendant', buttons[state.cursor.menu].id);
      renderDetail(menu[state.cursor.menu]);
      if (isProductionTop && menu[state.cursor.menu].kind === 'content') {
        var nextHash = '#' + menu[state.cursor.menu].id;
        if (window.location.hash !== nextHash && window.history && typeof window.history.pushState === 'function') window.history.pushState(null, '', nextHash);
        var lainToggle = document.getElementById('lain-toggle');
        if (lainToggle) lainToggle.href = 'lain.html' + nextHash;
      }
      updateStatusPosition();
      setMessage(state.message);
      if (focusItem) buttons[state.cursor.menu].focus();
    } finally {
      isSelecting = false;
    }
  }

  function activate() {
    var item = menu[store.getState().cursor.menu];
    if (item && item.kind === 'external') {
      finishMessage();
      window.location.href = item.href;
    }
  }

  function handleKeydown(event) {
    var action = window.RYOTEI_INPUT.keydownAction(event);
    if (!action) return;
    var cursor = store.getState().cursor.menu;
    if (action.type === 'move') select(cursor + action.delta, true);
    else if (action.type === 'enter') activate();
    else if (action.type === 'back') resetToMenu();
    event.preventDefault();
  }

  function handleThemeToggle() {
    setTheme(store.getState().theme === 'dark' ? 'light' : 'dark');
  }

  function handlePopstate() {
    var routeIndex = order.indexOf(window.RYOTEI_NAVIGATION.resolveRoute(window.location.href, pages));
    if (routeIndex >= 0) select(routeIndex, false);
    else resetToMenu(false);
  }

  function unmount() {
    for (var index = disposers.length - 1; index >= 0; index -= 1) disposers[index]();
    disposers = [];
    activeInstance = null;
  }

  function mount(doc) {
    if (activeInstance) return activeInstance;
    doc = doc || document;
    pages = window.SITE && window.SITE.PAGES;
    order = window.SITE && window.SITE.PAGE_ORDER;
    menu = [];
    store = null;
    menuList = doc.getElementById('menu-list');
    detailTitle = doc.getElementById('detail-title');
    detailCode = doc.getElementById('detail-code');
    detailContent = doc.getElementById('detail-content');
    messageText = doc.getElementById('message-text');
    screenName = doc.getElementById('screen-name');
    statusPosition = doc.getElementById('status-position');
    statusTheme = doc.getElementById('status-theme');
    themeToggle = doc.getElementById('theme-toggle');
    isProductionTop = /(?:\/index\.html|\/)$/.test(window.location.pathname || '');
    activeInstance = { document: doc };

    if (!pages || !Array.isArray(order)) {
      detailTitle.textContent = '読み込みエラー';
      detailContent.textContent = 'content.js のサイトデータを読み込めませんでした。';
      messageText.textContent = 'プレビューをWebサーバー経由で再読み込みしてください。';
      return activeInstance;
    }

    if (!window.RYOTEI_STATE || typeof window.RYOTEI_STATE.createStore !== 'function') {
      detailTitle.textContent = '読み込みエラー';
      detailContent.textContent = '共通状態ストアを読み込めませんでした。';
      messageText.textContent = 'プレビューをWebサーバー経由で再読み込みしてください。';
      return activeInstance;
    }

    menu = window.RYOTEI_CONTENT_ADAPTER.createEntities(pages, order);
    store = window.RYOTEI_STATE.createStore({
      theme: doc.documentElement.dataset.theme,
      view: window.RYOTEI_NAVIGATION.resolveView(window.location.href),
      screen: 'menu',
      cursor: { menu: 0, content: 0, settings: 0 },
      message: '',
    }, { counts: { menu: menu.length } });

    menu.forEach(function (item, index) {
      var button = doc.createElement('button');
      button.type = 'button';
      button.id = 'menu-item-' + index;
      button.className = 'menu-item';
      button.setAttribute('role', 'option');
      button.setAttribute('aria-selected', 'false');
      button.tabIndex = -1;
      var label = doc.createElement('span');
      label.textContent = item.title;
      var kind = doc.createElement('span');
      kind.className = 'menu-kind';
      kind.textContent = item.kind === 'external' ? 'LINK' : 'DATA';
      button.append(label, kind);
      button.addEventListener('click', function () {
        select(index, false);
        if (item.kind === 'external') activate();
      });
      button.addEventListener('focus', function () { select(index, false); });
      menuList.appendChild(button);
    });

    disposers.push(function () {
      while (menuList.firstChild) menuList.removeChild(menuList.firstChild);
    });
    themeToggle.addEventListener('click', handleThemeToggle);
    disposers.push(function () { themeToggle.removeEventListener('click', handleThemeToggle); });
    doc.addEventListener('keydown', handleKeydown);
    disposers.push(function () { doc.removeEventListener('keydown', handleKeydown); });
    if (isProductionTop && typeof window.addEventListener === 'function') {
      window.addEventListener('popstate', handlePopstate);
      disposers.push(function () { window.removeEventListener('popstate', handlePopstate); });
    }
    disposers.push(function () {
      messageRun += 1;
      if (messageTimer !== null && typeof clearTimeout === 'function') clearTimeout(messageTimer);
      messageTimer = null;
    });

    doc.getElementById('item-count').textContent = String(menu.length).padStart(2, '0');
    setTheme(store.getState().theme === 'light' ? 'light' : 'dark');
    var initialIndex = isProductionTop ? order.indexOf(window.RYOTEI_NAVIGATION.resolveRoute(window.location.href, pages)) : -1;
    if (isProductionTop && initialIndex < 0) resetToMenu(false);
    else select(initialIndex >= 0 ? initialIndex : 0, false);
    return activeInstance;
  }

  window.RYOTEI_RENDERER_2D = { mount: mount, unmount: unmount };
  mount(document);
}());
