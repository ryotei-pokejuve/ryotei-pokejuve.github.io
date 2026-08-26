const assert = require('node:assert/strict');
const fs = require('node:fs');
const net = require('node:net');
const os = require('node:os');
const path = require('node:path');
const { spawn } = require('node:child_process');

const ROOT = path.resolve(__dirname, '..');

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
  return {
    command(method, params = {}) {
      const id = nextId++;
      socket.send(JSON.stringify({ id, method, params }));
      return new Promise((resolve, reject) => pending.set(id, { resolve, reject }));
    },
    evaluate(expression) {
      const id = nextId++;
      socket.send(JSON.stringify({
        id,
        method: 'Runtime.evaluate',
        params: { expression, awaitPromise: true, returnByValue: true },
      }));
      return new Promise((resolve, reject) => pending.set(id, {
        resolve: (result) => resolve(result.result.value), reject,
      }));
    },
    close() { socket.close(); },
  };
}

async function waitFor(client, expression, message) {
  for (let attempt = 0; attempt < 100; attempt += 1) {
    if (await client.evaluate(expression)) return;
    await new Promise((resolve) => setTimeout(resolve, 20));
  }
  assert.fail(message);
}

async function press(client, key, code = key) {
  await client.command('Input.dispatchKeyEvent', { type: 'keyDown', key, code });
  await client.command('Input.dispatchKeyEvent', { type: 'keyUp', key, code });
}

const gateState = `(() => {
  const gate = document.getElementById('push-start-gate');
  return { hidden: gate.hidden, ariaHidden: gate.getAttribute('aria-hidden') };
})()`;

(async () => {
  const httpPort = await unusedPort();
  const debugPort = await unusedPort();
  const profileDir = fs.mkdtempSync(path.join(os.tmpdir(), 'push-start-qa-'));
  const server = spawn('python', ['-m', 'http.server', String(httpPort), '--bind', '127.0.0.1'], { cwd: ROOT, stdio: 'ignore' });
  const baseUrl = `http://127.0.0.1:${httpPort}/index.html`;
  const browser = spawn(findBrowser(), [
    '--headless=new', '--no-sandbox', '--no-first-run', '--no-default-browser-check',
    '--remote-allow-origins=*', `--remote-debugging-port=${debugPort}`, `--user-data-dir=${profileDir}`, baseUrl,
  ], { stdio: 'ignore' });
  let client;

  async function reloadWithStorage(script) {
    await client.evaluate(script);
    await client.command('Page.reload');
  }

  try {
    const targets = await waitForJson(`http://127.0.0.1:${debugPort}/json/list`);
    client = await connect(targets.find((target) => target.type === 'page' && target.url === baseUrl).webSocketDebuggerUrl);
    await waitFor(client, `document.readyState === 'complete' && window.RYOTEI_RENDERER_2D`, 'initial page did not load');

    await client.evaluate(`sessionStorage.setItem('ryotei-warp-entry', '1'); sessionStorage.removeItem('ryotei-push-start-consumed')`);
    assert.equal(await client.evaluate(`sessionStorage.getItem('ryotei-warp-entry')`), '1', 'the test setup stores the warp request');
    await client.command('Page.reload');
    await waitFor(client, `document.getElementById('warp-entry-overlay').classList.contains('is-active')`, 'warp entry did not start');
    assert.deepEqual(await client.evaluate(gateState), { hidden: true, ariaHidden: 'true' }, 'warp entry suppresses the gate while active');
    await waitFor(client, `sessionStorage.getItem('ryotei-warp-entry') === null && document.getElementById('push-start-gate').hidden`, 'warp entry did not suppress the gate');
    const warpInitial = await client.evaluate(`({
      gate: ${gateState},
      warp: {
        active: document.getElementById('warp-entry-overlay').classList.contains('is-active'),
        hidden: document.getElementById('warp-entry-overlay').hidden
      },
      entry: sessionStorage.getItem('ryotei-warp-entry')
    })`);
    assert.deepEqual(warpInitial, {
      gate: { hidden: true, ariaHidden: 'true' },
      warp: { active: false, hidden: true },
      entry: null,
    }, 'warp entry suppresses the gate and finishes cleanly');
    assert.deepEqual(await client.evaluate(gateState), { hidden: true, ariaHidden: 'true' }, 'the gate remains hidden after warp entry');

    await reloadWithStorage(`sessionStorage.removeItem('ryotei-warp-entry'); sessionStorage.removeItem('ryotei-push-start-consumed')`);
    await waitFor(client, `!document.getElementById('push-start-gate').hidden`, 'the PUSH START gate did not open');
    assert.equal(await client.evaluate(`document.activeElement.id`), 'push-start-button', 'the gate receives focus');
    const beforeKeyboard = await client.evaluate(`(() => {
      window.__pushStartQa = { bubbles: 0, history: 0, market: 0 };
      document.addEventListener('keydown', () => { window.__pushStartQa.bubbles += 1; });
      const pushState = history.pushState.bind(history);
      history.pushState = function () { window.__pushStartQa.history += 1; return pushState.apply(history, arguments); };
      document.querySelector('.menu-item:last-child').addEventListener('click', () => { window.__pushStartQa.market += 1; });
      return {
        selected: document.querySelector('.menu-item[aria-selected="true"]'),
        screen: document.getElementById('screen-name').textContent,
        hash: location.hash,
      };
    })()`);
    for (const [key, code] of [['ArrowUp', 'ArrowUp'], ['ArrowDown', 'ArrowDown'], ['ArrowLeft', 'ArrowLeft'], ['ArrowRight', 'ArrowRight'], ['Escape', 'Escape']]) {
      await press(client, key, code);
    }
    assert.deepEqual(await client.evaluate(`({
      selected: document.querySelector('.menu-item[aria-selected="true"]'),
      screen: document.getElementById('screen-name').textContent,
      hash: location.hash,
      bubbles: window.__pushStartQa.bubbles,
      history: window.__pushStartQa.history
    })`), { ...beforeKeyboard, bubbles: 0, history: 0 }, 'modal keyboard input cannot reach the application');
    await press(client, 'Tab', 'Tab');
    await press(client, 'Tab', 'Tab');
    assert.equal(await client.evaluate(`document.activeElement.id`), 'push-start-button', 'Tab remains trapped in the gate');
    await client.evaluate(`document.getElementById('menu-list').focus()`);
    assert.equal(await client.evaluate(`document.activeElement.id`), 'push-start-button', 'focus cannot escape the gate');

    await press(client, 'Enter', 'Enter');
    await waitFor(client, `document.getElementById('push-start-gate').hidden`, 'Enter did not close the gate');
    assert.equal(await client.evaluate(`sessionStorage.getItem('ryotei-push-start-consumed')`), '1', 'activation consumes the session gate');
    assert.equal(await client.evaluate(`window.__pushStartQa.market`), 0, 'keyboard activation does not activate CARD MARKET');
    await press(client, 'ArrowDown', 'ArrowDown');
    assert.notEqual(await client.evaluate(`document.getElementById('screen-name').textContent`), 'MENU', 'keyboard navigation resumes after closing the gate');

    await reloadWithStorage(`sessionStorage.removeItem('ryotei-warp-entry'); sessionStorage.removeItem('ryotei-push-start-consumed')`);
    await client.command('Emulation.setDeviceMetricsOverride', { width: 390, height: 844, mobile: true, deviceScaleFactor: 1 });
    await client.command('Emulation.setTouchEmulationEnabled', { enabled: true });
    await waitFor(client, `!document.getElementById('push-start-gate').hidden`, 'the touch test gate did not open');
    await client.evaluate(`(() => {
      window.__pushStartTouchQa = { market: 0, documentClicks: 0 };
      document.querySelector('.menu-item:last-child').addEventListener('click', () => { window.__pushStartTouchQa.market += 1; });
      document.addEventListener('click', (event) => {
        if (!document.getElementById('push-start-gate').contains(event.target)) window.__pushStartTouchQa.documentClicks += 1;
      });
    })()`);
    const point = await client.evaluate(`(() => {
      const rect = document.getElementById('push-start-button').getBoundingClientRect();
      return { x: rect.left + rect.width / 2, y: rect.top + rect.height / 2 };
    })()`);
    await client.command('Input.dispatchTouchEvent', { type: 'touchStart', touchPoints: [{ x: point.x, y: point.y, id: 1 }] });
    await client.command('Input.dispatchTouchEvent', { type: 'touchEnd', touchPoints: [] });
    await waitFor(client, `document.getElementById('push-start-gate').hidden`, 'touchstart did not close the gate');
    await new Promise((resolve) => setTimeout(resolve, 100));
    assert.deepEqual(await client.evaluate(`({
      consumed: sessionStorage.getItem('ryotei-push-start-consumed'),
      market: window.__pushStartTouchQa.market,
      documentClicks: window.__pushStartTouchQa.documentClicks,
      pathname: location.pathname
    })`), { consumed: '1', market: 0, documentClicks: 0, pathname: '/index.html' }, 'touch input does not leak a ghost click behind the gate');

    await client.command('Emulation.clearDeviceMetricsOverride');
    await client.command('Emulation.setTouchEmulationEnabled', { enabled: false });
    await reloadWithStorage(`sessionStorage.removeItem('ryotei-warp-entry'); sessionStorage.removeItem('ryotei-push-start-consumed')`);
    await client.evaluate(`window.RYOTEI_RENDERER_2D.unmount()`);
    assert.deepEqual(await client.evaluate(gateState), { hidden: true, ariaHidden: 'true' }, 'unmount hides the active gate');
    assert.equal(await client.evaluate(`sessionStorage.getItem('ryotei-push-start-consumed')`), null, 'unmount does not consume the gate');
    await client.evaluate(`window.RYOTEI_RENDERER_2D.mount(document)`);
    await waitFor(client, `!document.getElementById('push-start-gate').hidden`, 'remount did not restore an unconsumed gate');
    await press(client, ' ', 'Space');
    await waitFor(client, `document.getElementById('push-start-gate').hidden`, 'remounted gate did not close once');

    console.log('TASK-008 PUSH START gate browser test: PASS');
  } finally {
    if (client) {
      try { await client.command('Browser.close'); } catch (error) {}
      client.close();
    }
    browser.kill();
    server.kill();
    await Promise.all([
      browser.exitCode === null ? new Promise((resolve) => browser.once('exit', resolve)) : undefined,
      server.exitCode === null ? new Promise((resolve) => server.once('exit', resolve)) : undefined,
    ]);
    try {
      fs.rmSync(profileDir, { recursive: true, force: true, maxRetries: 20, retryDelay: 200 });
    } catch (error) {
      console.error(`PUSH START test profile cleanup failed: ${error.message}`);
    }
  }
})().catch((error) => {
  console.error(error.stack || error);
  process.exitCode = 1;
});
