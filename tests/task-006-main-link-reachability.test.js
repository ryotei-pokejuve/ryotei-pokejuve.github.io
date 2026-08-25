const assert = require('node:assert/strict');
const fs = require('node:fs');
const net = require('node:net');
const path = require('node:path');
const { spawn } = require('node:child_process');

const ROOT = path.resolve(__dirname, '..');
const FOOTER_HREFS = ['about.html', 'privacy.html', 'terms.html', 'contact.html'];

function findBrowser() {
  const candidates = [
    process.env.CHROME_PATH,
    path.join(process.env.ProgramFiles || 'C:\\Program Files', 'Google', 'Chrome', 'Application', 'chrome.exe'),
    path.join(process.env['ProgramFiles(x86)'] || 'C:\\Program Files (x86)', 'Microsoft', 'Edge', 'Application', 'msedge.exe'),
    path.join(process.env.ProgramFiles || 'C:\\Program Files', 'Microsoft', 'Edge', 'Application', 'msedge.exe'),
  ].filter(Boolean);
  const browser = candidates.find((candidate) => fs.existsSync(candidate));
  assert.ok(browser, 'Chrome or Edge is required (or set CHROME_PATH)');
  return browser;
}

async function unusedPort() {
  const server = net.createServer();
  await new Promise((resolve, reject) => server.listen(0, '127.0.0.1', resolve).once('error', reject));
  const port = server.address().port;
  await new Promise((resolve) => server.close(resolve));
  return port;
}

async function waitForJson(url) {
  let error;
  for (let attempt = 0; attempt < 100; attempt += 1) {
    try {
      const response = await fetch(url);
      if (response.ok) return response.json();
      error = new Error(`HTTP ${response.status}`);
    } catch (current) { error = current; }
    await new Promise((resolve) => setTimeout(resolve, 50));
  }
  throw error;
}

async function connect(webSocketUrl) {
  const socket = new WebSocket(webSocketUrl);
  await new Promise((resolve, reject) => {
    socket.addEventListener('open', resolve, { once: true });
    socket.addEventListener('error', reject, { once: true });
  });
  let nextId = 1;
  const pending = new Map();
  socket.addEventListener('message', (event) => {
    const message = JSON.parse(event.data);
    if (!message.id || !pending.has(message.id)) return;
    const handlers = pending.get(message.id);
    pending.delete(message.id);
    if (message.error) handlers.reject(new Error(message.error.message));
    else handlers.resolve(message.result);
  });
  function command(method, params = {}) {
    const id = nextId++;
    socket.send(JSON.stringify({ id, method, params }));
    return new Promise((resolve, reject) => pending.set(id, { resolve, reject }));
  }
  return {
    command,
    async evaluate(expression) {
      const result = await command('Runtime.evaluate', {
        expression, awaitPromise: true, returnByValue: true,
      });
      if (result.exceptionDetails) throw new Error(result.exceptionDetails.text);
      return result.result.value;
    },
    close() { socket.close(); },
  };
}

async function pressKey(client, key, code, windowsVirtualKeyCode) {
  await client.command('Input.dispatchKeyEvent', {
    type: 'keyDown', key, code, windowsVirtualKeyCode,
  });
  await client.command('Input.dispatchKeyEvent', {
    type: 'keyUp', key, code, windowsVirtualKeyCode,
  });
}

async function waitForPath(client, pathname) {
  let state;
  for (let attempt = 0; attempt < 100; attempt += 1) {
    state = await client.evaluate(`({ pathname: location.pathname, ready: document.readyState })`);
    if (state.pathname === pathname) return;
    await new Promise((resolve) => setTimeout(resolve, 25));
  }
  assert.fail(`navigation did not reach ${pathname}: ${JSON.stringify(state)}`);
}

async function openIndex(client, indexUrl) {
  await client.evaluate(`location.href = ${JSON.stringify(indexUrl)}`);
  await waitForPath(client, '/index.html');
  let count = 0;
  for (let attempt = 0; attempt < 100; attempt += 1) {
    count = await client.evaluate(`document.querySelectorAll('.menu-item').length`);
    if (count > 0) return;
    await new Promise((resolve) => setTimeout(resolve, 25));
  }
  assert.fail(`production menu did not render: ${count}`);
}

async function tabToFooterLink(client, href) {
  await client.evaluate(`document.activeElement?.blur()`);
  for (let attempt = 0; attempt < 30; attempt += 1) {
    await pressKey(client, 'Tab', 'Tab', 9);
    const activeHref = await client.evaluate(`document.activeElement?.getAttribute('href') || null`);
    if (activeHref === href) return;
  }
  assert.fail(`Tab did not reach footer link ${href}`);
}

async function tabToId(client, id) {
  await client.evaluate(`document.activeElement?.blur()`);
  for (let attempt = 0; attempt < 30; attempt += 1) {
    await pressKey(client, 'Tab', 'Tab', 9);
    if (await client.evaluate(`document.activeElement?.id`) === id) return;
  }
  assert.fail(`Tab did not reach #${id}`);
}

(async () => {
  const httpPort = await unusedPort();
  const debugPort = await unusedPort();
  const profileDir = fs.mkdtempSync(path.join(ROOT, '.main-links-qa-'));
  const server = spawn('python', ['-m', 'http.server', String(httpPort), '--bind', '127.0.0.1'], {
    cwd: ROOT, stdio: 'ignore',
  });
  const indexUrl = `http://127.0.0.1:${httpPort}/index.html`;
  const browser = spawn(findBrowser(), [
    '--headless=new', '--no-sandbox', '--no-first-run', '--no-default-browser-check',
    '--remote-allow-origins=*', `--remote-debugging-port=${debugPort}`, `--user-data-dir=${profileDir}`, indexUrl,
  ], { stdio: 'ignore' });
  let client;

  try {
    const targets = await waitForJson(`http://127.0.0.1:${debugPort}/json/list`);
    const target = targets.find((item) => item.type === 'page' && item.url === indexUrl);
    assert.ok(target, 'production index page target is available');
    client = await connect(target.webSocketDebuggerUrl);
    await openIndex(client, indexUrl);

    assert.deepEqual(
      await client.evaluate(`[...document.querySelectorAll('.site-footer a')].map((link) => link.getAttribute('href'))`),
      FOOTER_HREFS,
      'footer keeps the established major-page hrefs and order',
    );
    assert.equal(
      await client.evaluate(`RYOTEI_CONTENT_ADAPTER.createEntities(SITE.PAGES, SITE.PAGE_ORDER).find((item) => item.id === 'market').href`),
      'search.html',
      'CARD MARKET keeps its established destination',
    );

    for (const href of FOOTER_HREFS) {
      await client.evaluate(`document.querySelector('.site-footer a[href="${href}"]').click()`);
      await waitForPath(client, `/${href}`);
      await openIndex(client, indexUrl);

      await tabToFooterLink(client, href);
      assert.equal(
        await client.evaluate(`document.activeElement.getAttribute('href')`),
        href,
        `Tab reaches ${href} without rewriting its href`,
      );
      await pressKey(client, 'Enter', 'Enter', 13);
      await waitForPath(client, `/${href}`);
      await openIndex(client, indexUrl);
    }

    const marketIndex = await client.evaluate(`[...document.querySelectorAll('.menu-item')].findIndex((item) => item.textContent.includes('CARD MARKET'))`);
    assert.ok(marketIndex >= 0, 'CARD MARKET is present in the production menu');
    await client.evaluate(`document.querySelectorAll('.menu-item')[${marketIndex}].click()`);
    await waitForPath(client, '/search.html');
    await openIndex(client, indexUrl);

    await tabToId(client, 'menu-list');
    await pressKey(client, 'ArrowLeft', 'ArrowLeft', 37);
    assert.equal(
      await client.evaluate(`document.activeElement?.textContent.includes('CARD MARKET')`),
      true,
      'keyboard selection reaches CARD MARKET from the menu Tab stop',
    );
    await pressKey(client, 'Enter', 'Enter', 13);
    await waitForPath(client, '/search.html');

    console.log('TASK-006 main link reachability browser test: PASS');
  } finally {
    if (client) client.close();
    browser.kill();
    server.kill();
    await Promise.all([
      browser.exitCode === null ? new Promise((resolve) => browser.once('exit', resolve)) : undefined,
      server.exitCode === null ? new Promise((resolve) => server.once('exit', resolve)) : undefined,
    ]);
    fs.rmSync(profileDir, { recursive: true, force: true, maxRetries: 5, retryDelay: 100 });
  }
})().catch((error) => {
  console.error(error.stack || error);
  process.exitCode = 1;
});
