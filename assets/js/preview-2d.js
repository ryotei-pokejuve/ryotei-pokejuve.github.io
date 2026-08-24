(function () {
  'use strict';

  var THEME_KEY = 'ryotei-2d-theme';
  var pages = window.SITE && window.SITE.PAGES;
  var order = window.SITE && window.SITE.PAGE_ORDER;
  var menu = [];
  var state = { theme: document.documentElement.dataset.theme, screen: 'menu', cursor: 0, message: '' };
  var menuList = document.getElementById('menu-list');
  var detailTitle = document.getElementById('detail-title');
  var detailContent = document.getElementById('detail-content');
  var messageText = document.getElementById('message-text');
  var screenName = document.getElementById('screen-name');
  var statusPosition = document.getElementById('status-position');
  var statusTheme = document.getElementById('status-theme');
  var themeToggle = document.getElementById('theme-toggle');
  var isSelecting = false;

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
    state.theme = theme;
    document.documentElement.dataset.theme = theme;
    themeToggle.querySelector('span').textContent = theme.toUpperCase();
    statusTheme.textContent = theme.toUpperCase();
    themeToggle.setAttribute('aria-pressed', String(theme === 'light'));
    try { localStorage.setItem(THEME_KEY, theme); } catch (error) {}
  }

  function renderDetail(item) {
    detailTitle.textContent = item.title;
    screenName.textContent = item.kind === 'external' ? 'LINK' : item.id.toUpperCase();
    if (item.kind === 'external') {
      detailContent.innerHTML = '';
      var box = document.createElement('div');
      box.className = 'external-card';
      var description = document.createElement('p');
      description.textContent = plainSummary(item);
      var link = document.createElement('a');
      link.className = 'open-link';
      link.href = item.href;
      link.textContent = 'カード相場を開く';
      box.append(description, link);
      detailContent.appendChild(box);
    } else {
      detailContent.innerHTML = '<div class="page-content" id="page-content">' + pageHtml(item.page) + '</div>';
      if (typeof item.page.onMount === 'function') item.page.onMount();
    }
  }

  function updateStatusPosition() {
    statusPosition.textContent = String(state.cursor + 1).padStart(2, '0') + '/' + String(menu.length).padStart(2, '0');
  }

  function resetToMenu() {
    state.screen = 'menu';
    menuList.tabIndex = 0;
    var buttons = menuList.querySelectorAll('.menu-item');
    buttons.forEach(function (button) {
      button.setAttribute('aria-selected', 'false');
      button.tabIndex = -1;
    });
    menuList.removeAttribute('aria-activedescendant');
    detailTitle.textContent = 'MENU';
    detailContent.textContent = '方向キーまたはタッチで項目を選択してください。';
    screenName.textContent = 'MENU';
    updateStatusPosition();
    state.message = 'メニューへ戻りました。方向キーまたはタッチで項目を選択できます。';
    messageText.textContent = state.message;
    menuList.focus();
  }

  function select(index, focusItem) {
    if (!menu.length || isSelecting) return;
    var nextCursor = (index + menu.length) % menu.length;
    if (state.screen === 'content' && nextCursor === state.cursor) {
      if (focusItem) menuList.querySelectorAll('.menu-item')[nextCursor].focus();
      return;
    }
    isSelecting = true;
    try {
      state.cursor = nextCursor;
      state.screen = 'content';
      var buttons = menuList.querySelectorAll('.menu-item');
      menuList.tabIndex = -1;
      buttons.forEach(function (button, buttonIndex) {
        var selected = buttonIndex === state.cursor;
        button.setAttribute('aria-selected', String(selected));
        button.tabIndex = selected ? 0 : -1;
      });
      menuList.setAttribute('aria-activedescendant', buttons[state.cursor].id);
      renderDetail(menu[state.cursor]);
      updateStatusPosition();
      state.message = deriveMessage(menu[state.cursor]);
      messageText.textContent = state.message;
      if (focusItem) buttons[state.cursor].focus();
    } finally {
      isSelecting = false;
    }
  }

  function activate() {
    var item = menu[state.cursor];
    if (item && item.kind === 'external') window.location.href = item.href;
  }

  function isEditing(target) {
    return target && (target.matches('input, textarea, select') || target.isContentEditable);
  }

  function handleKeydown(event) {
    if (isEditing(event.target) || event.altKey || event.ctrlKey || event.metaKey) return;
    var handled = true;
    if (event.key === 'ArrowUp' || event.key === 'ArrowLeft') select(state.cursor - 1, true);
    else if (event.key === 'ArrowDown' || event.key === 'ArrowRight') select(state.cursor + 1, true);
    else if (event.key === 'Enter' && event.target.classList.contains('menu-item')) activate();
    else if (event.key === 'Escape') resetToMenu();
    else handled = false;
    if (handled) event.preventDefault();
  }

  if (!pages || !Array.isArray(order)) {
    detailTitle.textContent = '読み込みエラー';
    detailContent.textContent = 'content.js のサイトデータを読み込めませんでした。';
    messageText.textContent = 'プレビューをWebサーバー経由で再読み込みしてください。';
    return;
  }

  menu = order.filter(function (id) { return pages[id]; }).map(function (id) {
    return { id: id, title: pages[id].title || id, page: pages[id], kind: 'content' };
  });
  menu.push({ id: 'market', title: 'CARD MARKET', kind: 'external', href: 'search.html' });

  menu.forEach(function (item, index) {
    var button = document.createElement('button');
    button.type = 'button';
    button.id = 'menu-item-' + index;
    button.className = 'menu-item';
    button.setAttribute('role', 'option');
    button.setAttribute('aria-selected', 'false');
    button.tabIndex = -1;
    var label = document.createElement('span');
    label.textContent = item.title;
    var kind = document.createElement('span');
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

  document.getElementById('item-count').textContent = String(menu.length).padStart(2, '0');
  themeToggle.addEventListener('click', function () { setTheme(state.theme === 'dark' ? 'light' : 'dark'); });
  document.addEventListener('keydown', handleKeydown);
  setTheme(state.theme === 'light' ? 'light' : 'dark');
  select(0, false);
}());
