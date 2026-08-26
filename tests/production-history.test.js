const assert = require('node:assert/strict');
const fs = require('node:fs');
const net = require('node:net');
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
    evaluate(expression) {
      const id = nextId++;
      socket.send(JSON.stringify({ id, method: 'Runtime.evaluate', params: { expression, awaitPromise: true, returnByValue: true } }));
      return new Promise((resolve, reject) => pending.set(id, {
        resolve: (result) => resolve(result.result.value), reject,
      }));
    },
    close() { socket.close(); },
  };
}

async function waitForState(client, expectedHash, expectedScreen) {
  let state;
  for (let attempt = 0; attempt < 100; attempt += 1) {
    state = await client.evaluate(`({
      ready: document.readyState,
      hash: location.hash,
      screen: document.getElementById('screen-name')?.textContent,
      title: document.getElementById('detail-title')?.textContent,
      items: document.querySelectorAll('.menu-item').length
    })`);
    if (state.ready !== 'loading' && state.items > 0 && state.hash === expectedHash && state.screen === expectedScreen) return state;
    await new Promise((resolve) => setTimeout(resolve, 25));
  }
  assert.fail(`history state did not settle: ${JSON.stringify(state)}`);
}

(async () => {
  const httpPort = await unusedPort();
  const debugPort = await unusedPort();
  const profileDir = fs.mkdtempSync(path.join(ROOT, '.history-qa-'));
  const server = spawn('python', ['-m', 'http.server', String(httpPort), '--bind', '127.0.0.1'], { cwd: ROOT, stdio: 'ignore' });
  const baseUrl = `http://127.0.0.1:${httpPort}/index.html`;
  const browser = spawn(findBrowser(), [
    '--headless=new', '--no-sandbox', '--no-first-run', '--no-default-browser-check',
    '--remote-allow-origins=*', `--remote-debugging-port=${debugPort}`, `--user-data-dir=${profileDir}`, baseUrl,
  ], { stdio: 'ignore' });
  let client;

  try {
    const targets = await waitForJson(`http://127.0.0.1:${debugPort}/json/list`);
    client = await connect(targets.find((target) => target.type === 'page').webSocketDebuggerUrl);

    const initial = await waitForState(client, '', 'MENU');
    assert.equal(initial.title, 'MENU', 'hashless initial visit renders MENU');

    await client.evaluate(`document.querySelectorAll('.menu-item')[0].click()`);
    await waitForState(client, '#top', 'TOP');
    await client.evaluate(`document.querySelectorAll('.menu-item')[1].click()`);
    await waitForState(client, '#videos', 'VIDEOS');

    await client.evaluate('history.back()');
    await waitForState(client, '#top', 'TOP');
    await client.evaluate('history.back()');
    const hashless = await waitForState(client, '', 'MENU');
    assert.equal(hashless.title, 'MENU', 'back to the hashless entry restores MENU');

    await client.evaluate('history.forward()');
    await waitForState(client, '#top', 'TOP');
    await client.evaluate('history.forward()');
    await waitForState(client, '#videos', 'VIDEOS');

    await client.evaluate(`location.href = ${JSON.stringify(`${baseUrl}#videos`)}`);
    await waitForState(client, '#videos', 'VIDEOS');
    console.log('production pushState/popstate history regression test: PASS');
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
