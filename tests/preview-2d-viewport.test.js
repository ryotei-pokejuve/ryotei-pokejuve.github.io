const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const net = require('node:net');
const path = require('node:path');
const { spawn } = require('node:child_process');

const ROOT = path.resolve(__dirname, '..');
const PAGE_URL = process.env.PREVIEW_2D_PAGE_URL || '/preview-2d.html';
const debug = (...values) => { if (process.env.DEBUG_QA) console.error('[qa]', ...values); };

function findBrowser() {
  const programFiles = process.env.ProgramFiles || 'C:\\Program Files';
  const programFilesX86 = process.env['ProgramFiles(x86)'] || 'C:\\Program Files (x86)';
  const localAppData = process.env.LOCALAPPDATA || '';
  const candidates = [
    process.env.CHROME_PATH,
    path.join(programFiles, 'Google', 'Chrome', 'Application', 'chrome.exe'),
    path.join(programFilesX86, 'Google', 'Chrome', 'Application', 'chrome.exe'),
    path.join(localAppData, 'Google', 'Chrome', 'Application', 'chrome.exe'),
    path.join(programFiles, 'Microsoft', 'Edge', 'Application', 'msedge.exe'),
    path.join(programFilesX86, 'Microsoft', 'Edge', 'Application', 'msedge.exe'),
  ].filter(Boolean);
  const browser = candidates.find((candidate) => fs.existsSync(candidate));
  assert.ok(browser, 'Chrome or Edge is required (or set CHROME_PATH)');
  return browser;
}

async function unusedPort() {
  const server = net.createServer();
  await new Promise((resolve, reject) => server.listen(0, '127.0.0.1', resolve).once('error', reject));
  const { port } = server.address();
  await new Promise((resolve) => server.close(resolve));
  return port;
}

async function waitFor(url, description) {
  let lastError;
  for (let attempt = 0; attempt < 80; attempt += 1) {
    try {
      const response = await fetch(url);
      if (response.ok) return response;
      lastError = new Error(`HTTP ${response.status}`);
    } catch (error) {
      lastError = error;
    }
    await new Promise((resolve) => setTimeout(resolve, 100));
  }
  throw new Error(`${description} did not start: ${lastError && lastError.message}`);
}

class CdpClient {
  constructor(url) {
    this.nextId = 1;
    this.pending = new Map();
    this.listeners = new Map();
    this.url = new URL(url);
    this.socket = null;
    this.buffer = Buffer.alloc(0);
    this.upgraded = false;
  }

  async open() {
    const key = crypto.randomBytes(16).toString('base64');
    this.socket = net.connect(Number(this.url.port), this.url.hostname);
    await new Promise((resolve, reject) => {
      this.socket.once('error', reject);
      this.socket.once('connect', resolve);
    });
    this.socket.on('data', (chunk) => this.onData(chunk));
    this.socket.on('error', (error) => debug('websocket error', error.message));
    this.socket.write([
      `GET ${this.url.pathname}${this.url.search} HTTP/1.1`,
      `Host: ${this.url.host}`,
      'Upgrade: websocket',
      'Connection: Upgrade',
      `Sec-WebSocket-Key: ${key}`,
      'Sec-WebSocket-Version: 13',
      'Origin: http://127.0.0.1',
      '', '',
    ].join('\r\n'));
    for (let attempt = 0; attempt < 50 && !this.upgraded; attempt += 1) {
      await new Promise((resolve) => setTimeout(resolve, 20));
    }
    assert.equal(this.upgraded, true, 'CDP WebSocket handshake succeeds');
  }

  onData(chunk) {
    this.buffer = Buffer.concat([this.buffer, chunk]);
    if (!this.upgraded) {
      const headerEnd = this.buffer.indexOf('\r\n\r\n');
      if (headerEnd < 0) return;
      const headers = this.buffer.subarray(0, headerEnd).toString('utf8');
      assert.match(headers, /^HTTP\/1\.1 101 /, `CDP upgrade failed: ${headers.split('\r\n')[0]}`);
      this.buffer = this.buffer.subarray(headerEnd + 4);
      this.upgraded = true;
    }
    while (this.readFrame()) {}
  }

  readFrame() {
    if (this.buffer.length < 2) return false;
    const opcode = this.buffer[0] & 0x0f;
    let length = this.buffer[1] & 0x7f;
    let offset = 2;
    if (length === 126) {
      if (this.buffer.length < 4) return false;
      length = this.buffer.readUInt16BE(2);
      offset = 4;
    } else if (length === 127) {
      if (this.buffer.length < 10) return false;
      length = Number(this.buffer.readBigUInt64BE(2));
      offset = 10;
    }
    if (this.buffer.length < offset + length) return false;
    const payload = this.buffer.subarray(offset, offset + length);
    this.buffer = this.buffer.subarray(offset + length);
    if (opcode === 1) this.onMessage(JSON.parse(payload.toString('utf8')));
    if (opcode === 9) this.writeFrame(0x8a, payload);
    if (opcode === 8) debug('websocket closed by browser');
    return this.buffer.length > 0;
  }

  writeText(text) {
    this.writeFrame(0x81, Buffer.from(text));
  }

  writeFrame(firstByte, payload) {
    const mask = crypto.randomBytes(4);
    const header = payload.length < 126
      ? Buffer.from([firstByte, 0x80 | payload.length])
      : Buffer.from([firstByte, 0xfe, payload.length >> 8, payload.length & 0xff]);
    const masked = Buffer.allocUnsafe(payload.length);
    for (let index = 0; index < payload.length; index += 1) masked[index] = payload[index] ^ mask[index % 4];
    this.socket.write(Buffer.concat([header, mask, masked]));
  }

  onMessage(message) {
    if (message.id) {
      const pending = this.pending.get(message.id);
      if (!pending) return;
      this.pending.delete(message.id);
      if (message.error) pending.reject(new Error(message.error.message));
      else pending.resolve(message.result);
      return;
    }
    const listeners = this.listeners.get(message.method) || [];
    listeners.forEach((listener) => listener(message.params));
  }

  on(method, listener) {
    const listeners = this.listeners.get(method) || [];
    listeners.push(listener);
    this.listeners.set(method, listeners);
  }

  send(method, params = {}) {
    const id = this.nextId++;
    return new Promise((resolve, reject) => {
      const timer = setTimeout(() => {
        this.pending.delete(id);
        reject(new Error(`CDP command timed out: ${method}`));
      }, 5000);
      this.pending.set(id, {
        resolve: (value) => { clearTimeout(timer); resolve(value); },
        reject: (error) => { clearTimeout(timer); reject(error); },
      });
      this.writeText(JSON.stringify({ id, method, params }));
    });
  }

  async evaluate(expression) {
    const result = await this.send('Runtime.evaluate', {
      expression,
      awaitPromise: true,
      returnByValue: true,
    });
    if (result.exceptionDetails) throw new Error(result.exceptionDetails.text);
    return result.result.value;
  }

  close() {
    this.socket.end();
  }
}

async function waitForPage(client) {
  let lastState;
  for (let attempt = 0; attempt < 80; attempt += 1) {
    lastState = await client.evaluate(`({
      readyState: document.readyState,
      menuItems: document.querySelectorAll('.menu-item').length,
      href: location.href,
      detail: document.getElementById('detail-content')?.textContent
    })`);
    if (lastState.readyState !== 'loading' && lastState.menuItems === 11 && lastState.detail) return;
    await new Promise((resolve) => setTimeout(resolve, 50));
  }
  throw new Error(`preview-2d did not finish rendering: ${JSON.stringify(lastState)}`);
}

async function pressTab(client, shift = false) {
  const modifiers = shift ? 8 : 0;
  await client.send('Input.dispatchKeyEvent', {
    type: 'keyDown', key: 'Tab', code: 'Tab', windowsVirtualKeyCode: 9, modifiers,
  });
  await client.send('Input.dispatchKeyEvent', {
    type: 'keyUp', key: 'Tab', code: 'Tab', windowsVirtualKeyCode: 9, modifiers,
  });
}

(async () => {
  const httpPort = await unusedPort();
  const debugPort = await unusedPort();
  const profileDir = fs.mkdtempSync(path.join(ROOT, '.preview-qa-'));
  const server = spawn('python', ['-m', 'http.server', String(httpPort), '--bind', '127.0.0.1'], {
    cwd: ROOT,
    stdio: 'ignore',
  });
  const pageUrl = `http://127.0.0.1:${httpPort}${PAGE_URL}`;
  const browser = spawn(findBrowser(), [
    '--headless=new',
    '--no-sandbox',
    '--single-process',
    '--use-gl=angle',
    '--use-angle=swiftshader',
    '--disable-features=Vulkan',
    '--no-first-run',
    '--no-default-browser-check',
    '--remote-allow-origins=*',
    `--remote-debugging-port=${debugPort}`,
    `--user-data-dir=${profileDir}`,
    pageUrl,
  ], { stdio: ['ignore', 'ignore', 'pipe'] });
  browser.stderr.on('data', (chunk) => debug('browser:', chunk.toString().trim()));
  let client;

  try {
    debug('waiting for server', pageUrl);
    await waitFor(pageUrl, 'local HTTP server');
    debug('waiting for browser', debugPort);
    const targetsResponse = await waitFor(`http://127.0.0.1:${debugPort}/json/list`, 'headless browser');
    const targets = await targetsResponse.json();
    const target = targets.find((item) => item.type === 'page' && item.url.includes(PAGE_URL));
    assert.ok(target, 'preview page target is available');

    client = new CdpClient(target.webSocketDebuggerUrl);
    await client.open();
    debug('connected to page');
    const consoleErrors = [];
    const exceptions = [];
    client.on('Runtime.consoleAPICalled', (event) => {
      if (event.type === 'error') consoleErrors.push(event.args.map((arg) => arg.value || arg.description).join(' '));
    });
    client.on('Runtime.exceptionThrown', (event) => exceptions.push(event.exceptionDetails.text));
    await client.send('Runtime.enable');
    await client.send('Page.enable');

    for (const viewport of [
      { width: 1440, height: 900, label: 'Desktop 1440x900', menuColumns: 1, adHeight: 90 },
      { width: 760, height: 900, label: '760px breakpoint', menuColumns: 2, adHeight: 90 },
    ]) {
      debug('checking', viewport.label);
      const errorStart = consoleErrors.length;
      const exceptionStart = exceptions.length;
      await client.send('Emulation.setDeviceMetricsOverride', {
        width: viewport.width,
        height: viewport.height,
        deviceScaleFactor: 1,
        mobile: false,
      });
      await client.send('Page.reload', { ignoreCache: true });
      await waitForPage(client);

      const layout = await client.evaluate(`(() => ({
        innerWidth,
        rootClientWidth: document.documentElement.clientWidth,
        rootScrollWidth: document.documentElement.scrollWidth,
        bodyScrollWidth: document.body.scrollWidth,
        shellRight: document.querySelector('.terminal-shell').getBoundingClientRect().right,
        menuColumns: getComputedStyle(document.querySelector('.menu-list')).gridTemplateColumns.split(' ').length,
        menuItemHeights: [...document.querySelectorAll('.menu-item')]
          .map((item) => item.getBoundingClientRect().height),
        themeHeight: document.getElementById('theme-toggle').getBoundingClientRect().height,
        adMinHeight: parseFloat(getComputedStyle(document.querySelector('.ad-reserve')).minHeight),
        adHeight: document.querySelector('.ad-reserve').getBoundingClientRect().height
      }))()`);
      assert.equal(layout.innerWidth, viewport.width, `${viewport.label}: requested viewport is active`);
      assert.ok(layout.rootScrollWidth <= layout.rootClientWidth, `${viewport.label}: document has no horizontal overflow`);
      assert.ok(layout.bodyScrollWidth <= layout.rootClientWidth, `${viewport.label}: body has no horizontal overflow`);
      assert.ok(layout.shellRight <= layout.rootClientWidth + 0.5, `${viewport.label}: terminal shell stays inside viewport`);
      assert.equal(layout.menuColumns, viewport.menuColumns, `${viewport.label}: expected menu grid is rendered`);
      assert.ok(
        layout.menuItemHeights.every((height) => height >= 44),
        `${viewport.label}: every menu action is at least 44px high`,
      );
      assert.ok(layout.themeHeight >= 44, `${viewport.label}: Theme action is at least 44px high`);
      assert.equal(layout.adMinHeight, viewport.adHeight, `${viewport.label}: ad slot keeps its CSS reserved height`);
      assert.ok(layout.adHeight >= viewport.adHeight, `${viewport.label}: rendered ad slot keeps its reserved height`);

      await client.evaluate(`document.activeElement && document.activeElement.blur()`);
      await pressTab(client);
      const firstFocus = await client.evaluate(`(() => {
        const element = document.activeElement;
        const style = getComputedStyle(element);
        const rect = element.getBoundingClientRect();
        return {
          className: element.className,
          outlineStyle: style.outlineStyle,
          outlineWidth: parseFloat(style.outlineWidth),
          outlineColor: style.outlineColor,
          visible: rect.width > 0 && rect.height > 0 && rect.bottom > 0 && rect.right > 0
        };
      })()`);
      assert.match(firstFocus.className, /skip-link/, `${viewport.label}: Tab starts at the skip link`);
      assert.notEqual(firstFocus.outlineStyle, 'none', `${viewport.label}: focus-visible has an outline style`);
      assert.ok(firstFocus.outlineWidth >= 2, `${viewport.label}: focus-visible outline is at least 2px`);
      assert.notEqual(firstFocus.outlineColor, 'rgba(0, 0, 0, 0)', `${viewport.label}: focus outline is not transparent`);
      assert.equal(firstFocus.visible, true, `${viewport.label}: focused skip link is visible on screen`);

      await pressTab(client);
      assert.equal(await client.evaluate('document.activeElement.id'), 'theme-toggle', `${viewport.label}: Theme is second in Tab order`);
      await pressTab(client);
      if (PAGE_URL === '/index.html') {
        assert.equal(await client.evaluate('document.activeElement.id'), 'lain-toggle', `${viewport.label}: Lain mode follows Theme in production`);
        await pressTab(client);
      }
      const expectedMenuFocus = PAGE_URL === '/index.html' ? 'menu-list' : 'menu-item-0';
      assert.equal(await client.evaluate('document.activeElement.id'), expectedMenuFocus, `${viewport.label}: menu control follows header actions in Tab order`);
      assert.deepEqual(consoleErrors.slice(errorStart), [], `${viewport.label}: console.error count is zero`);
      assert.deepEqual(exceptions.slice(exceptionStart), [], `${viewport.label}: uncaught JavaScript exception count is zero`);
    }

    console.log('preview-2d viewport browser test: PASS');
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
