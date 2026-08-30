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
  var SOUND_KEY = 'ryotei-2d-sound';
  var WARP_ENTRY_KEY = 'ryotei-warp-entry';
  var PUSH_START_KEY = 'ryotei-push-start-consumed';
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
  var soundToggle = null;
  var soundOn = false;
  var soundReady = false;
  var audioContext = null;
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
    if (item.kind === 'external') return 'カードの相場を調べてみよう…カード名や型番から参考価格を検索できます。';
    var scratch = document.createElement('div');
    scratch.innerHTML = pageHtml(item.page);
    var text = (scratch.textContent || '').replace(/\s+/g, ' ').trim();
    return text || item.title + ' の情報を表示します。';
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

  function beep(frequency, duration) {
    if (!soundOn || !soundReady) return;
    try {
      var AudioContext = window.AudioContext || window.webkitAudioContext;
      if (typeof AudioContext !== 'function') return;
      audioContext = audioContext || new AudioContext();
      var oscillator = audioContext.createOscillator();
      var gain = audioContext.createGain();
      var length = duration || 0.06;
      oscillator.type = 'sine';
      oscillator.frequency.value = frequency;
      oscillator.connect(gain);
      gain.connect(audioContext.destination);
      gain.gain.setValueAtTime(0.04, audioContext.currentTime);
      gain.gain.exponentialRampToValueAtTime(0.0001, audioContext.currentTime + length);
      oscillator.start();
      oscillator.stop(audioContext.currentTime + length);
    } catch (error) {}
  }

  function setSound(enabled, confirmWithSound) {
    soundOn = Boolean(enabled);
    if (!soundToggle) return;
    soundToggle.querySelector('span').textContent = soundOn ? 'ON' : 'OFF';
    soundToggle.setAttribute('aria-pressed', String(soundOn));
    try { localStorage.setItem(SOUND_KEY, soundOn ? 'on' : 'off'); } catch (error) {}
    if (confirmWithSound && soundOn) beep(660, 0.06);
  }

  function loadSoundPreference() {
    try { return localStorage.getItem(SOUND_KEY) === 'on'; } catch (error) { return false; }
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
      link.textContent = 'カード相場を調べる';
      link.addEventListener('click', function () {
        beep(740, 0.06);
        finishMessage();
        window.location.href = item.href;
      });
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
      beep(440, 0.045);
      if (focusItem) buttons[state.cursor.menu].focus();
    } finally {
      isSelecting = false;
    }
  }

  function handleKeydown(event) {
    var action = window.RYOTEI_INPUT.keydownAction(event);
    if (!action) return;
    var cursor = store.getState().cursor.menu;
    if (action.type === 'move') select(cursor + action.delta, true);
    else if (action.type === 'back') resetToMenu();
    event.preventDefault();
  }

  function handleThemeToggle() {
    setTheme(store.getState().theme === 'dark' ? 'light' : 'dark');
  }

  function handleSoundToggle() {
    setSound(!soundOn, true);
  }

  function handlePopstate() {
    var routeIndex = order.indexOf(window.RYOTEI_NAVIGATION.resolveRoute(window.location.href, pages));
    if (routeIndex >= 0) select(routeIndex, false);
    else resetToMenu(false);
  }

  function playWarpEntry(doc) {
    if (!isProductionTop) return;
    try {
      if (sessionStorage.getItem(WARP_ENTRY_KEY) !== '1') return;
    } catch (error) {
      return;
    }

    var overlay = doc.getElementById('warp-entry-overlay');
    var reducedMotion = typeof window.matchMedia === 'function'
      && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var warpTimer = null;
    var finished = false;

    function finishWarpEntry() {
      if (finished) return;
      finished = true;
      if (warpTimer !== null && typeof clearTimeout === 'function') clearTimeout(warpTimer);
      warpTimer = null;
      if (overlay) {
        overlay.classList.remove('is-active');
        overlay.hidden = true;
        overlay.removeEventListener('animationend', finishWarpEntry);
      }
      try { sessionStorage.removeItem(WARP_ENTRY_KEY); } catch (error) {}
    }

    disposers.push(finishWarpEntry);
    if (!overlay || reducedMotion) {
      finishWarpEntry();
      return;
    }

    overlay.hidden = false;
    overlay.addEventListener('animationend', finishWarpEntry);
    overlay.classList.add('is-active');
    if (typeof setTimeout === 'function') warpTimer = setTimeout(finishWarpEntry, 700);
  }

  function getSessionValue(key) {
    try { return sessionStorage.getItem(key); } catch (error) { return null; }
  }

  function hidePushStartGate(doc) {
    var gate = doc.getElementById('push-start-gate');
    if (!gate) return;
    gate.setAttribute('aria-hidden', 'true');
    gate.hidden = true;
  }

  function mountPushStartGate(doc) {
    var gate = doc.getElementById('push-start-gate');
    var pushStartButton = doc.getElementById('push-start-button');
    if (!gate || !pushStartButton) return;

    var active = true;
    var previousFocus = doc.activeElement;
    var touchOptions = { passive: false };

    function removeListeners() {
      doc.removeEventListener('keydown', handlePushStartKeydown, true);
      doc.removeEventListener('focusin', handlePushStartFocus, true);
      pushStartButton.removeEventListener('touchstart', handlePushStartTouch, touchOptions);
      pushStartButton.removeEventListener('click', handlePushStartClick);
    }

    function restoreFocus() {
      var focusTarget = previousFocus;
      if (!focusTarget
        || focusTarget === gate
        || gate.contains(focusTarget)
        || !focusTarget.isConnected
        || typeof focusTarget.focus !== 'function') {
        focusTarget = menuList;
      }
      if (focusTarget && typeof focusTarget.focus === 'function') focusTarget.focus();
    }

    function closePushStartGate(restore) {
      if (!active) return;
      active = false;
      try { sessionStorage.setItem(PUSH_START_KEY, '1'); } catch (error) {}
      hidePushStartGate(doc);
      removeListeners();
      if (restore) restoreFocus();
    }

    function handlePushStartKeydown(event) {
      if (!active) return;
      if (event.key === 'Enter' || event.key === ' ') {
        event.preventDefault();
        event.stopPropagation();
        pushStartButton.click();
        return;
      }
      event.preventDefault();
      event.stopPropagation();
      if (event.key === 'Tab') pushStartButton.focus();
    }

    function handlePushStartFocus(event) {
      if (active && !gate.contains(event.target)) pushStartButton.focus();
    }

    function handlePushStartTouch(event) {
      event.preventDefault();
      event.stopPropagation();
      closePushStartGate(true);
    }

    function handlePushStartClick(event) {
      event.preventDefault();
      event.stopPropagation();
      closePushStartGate(true);
    }

    doc.addEventListener('keydown', handlePushStartKeydown, true);
    doc.addEventListener('focusin', handlePushStartFocus, true);
    pushStartButton.addEventListener('touchstart', handlePushStartTouch, touchOptions);
    pushStartButton.addEventListener('click', handlePushStartClick);
    gate.hidden = false;
    gate.setAttribute('aria-hidden', 'false');
    pushStartButton.focus();
    disposers.push(function () {
      active = false;
      hidePushStartGate(doc);
      removeListeners();
    });
  }

  function unmount() {
    for (var index = disposers.length - 1; index >= 0; index -= 1) disposers[index]();
    disposers = [];
    soundReady = false;
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
    soundToggle = doc.getElementById('sound-toggle');
    soundOn = false;
    soundReady = false;
    audioContext = null;
    isProductionTop = /(?:\/index\.html|\/)$/.test(window.location.pathname || '');
    var warpEntryRequested = getSessionValue(WARP_ENTRY_KEY) === '1';
    var pushStartConsumed = getSessionValue(PUSH_START_KEY) === '1';
    var shouldPlayWarpEntry = isProductionTop && warpEntryRequested;
    var shouldShowPushStart = false; // PUSH START gate retired
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
      button.addEventListener('click', function () { select(index, false); });
      button.addEventListener('focus', function () { select(index, false); });
      menuList.appendChild(button);
    });

    disposers.push(function () {
      while (menuList.firstChild) menuList.removeChild(menuList.firstChild);
    });
    themeToggle.addEventListener('click', handleThemeToggle);
    disposers.push(function () { themeToggle.removeEventListener('click', handleThemeToggle); });
    if (soundToggle) {
      setSound(loadSoundPreference(), false);
      soundToggle.addEventListener('click', handleSoundToggle);
      disposers.push(function () { soundToggle.removeEventListener('click', handleSoundToggle); });
    }
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
      if (audioContext && typeof audioContext.close === 'function') {
        try { audioContext.close(); } catch (error) {}
      }
      audioContext = null;
    });

    doc.getElementById('item-count').textContent = String(menu.length).padStart(2, '0');
    setTheme(store.getState().theme === 'light' ? 'light' : 'dark');
    var initialIndex = isProductionTop ? order.indexOf(window.RYOTEI_NAVIGATION.resolveRoute(window.location.href, pages)) : -1;
    if (isProductionTop && initialIndex < 0) resetToMenu(false);
    else select(initialIndex >= 0 ? initialIndex : 0, false);
    soundReady = true;
    if (shouldPlayWarpEntry) {
      hidePushStartGate(doc);
      playWarpEntry(doc);
    }
    else if (shouldShowPushStart) mountPushStartGate(doc);
    return activeInstance;
  }

  window.RYOTEI_RENDERER_2D = { mount: mount, unmount: unmount };
  mount(document);
}());
