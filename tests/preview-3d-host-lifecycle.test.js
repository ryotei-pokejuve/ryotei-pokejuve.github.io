const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

class Element {
  constructor(tagName, document) {
    this.tagName = tagName.toUpperCase();
    this.ownerDocument = document;
    this.parentNode = null;
    this.children = [];
    this.listeners = {};
    this.attributes = {};
    this.dataset = {};
    this.className = '';
    this.hidden = false;
    this.value = 0;
    this._textContent = '';
    this.textWriteCount = 0;
  }

  get firstChild() { return this.children[0] || null; }
  get textContent() { return this._textContent; }
  set textContent(value) {
    this._textContent = String(value);
    this.textWriteCount += 1;
  }

  appendChild(child) {
    if (child.parentNode) child.parentNode.removeChild(child);
    child.parentNode = this;
    this.children.push(child);
    return child;
  }

  insertBefore(child, reference) {
    if (child.parentNode) child.parentNode.removeChild(child);
    child.parentNode = this;
    const index = reference ? this.children.indexOf(reference) : -1;
    if (index >= 0) this.children.splice(index, 0, child);
    else this.children.push(child);
    return child;
  }

  removeChild(child) {
    const index = this.children.indexOf(child);
    if (index >= 0) {
      this.children.splice(index, 1);
      child.parentNode = null;
    }
    return child;
  }

  remove() {
    if (this.parentNode) this.parentNode.removeChild(this);
  }

  setAttribute(name, value) {
    const stringValue = String(value);
    this.attributes[name] = stringValue;
    if (name === 'id') this.id = stringValue;
    if (name === 'class') this.className = stringValue;
  }

  addEventListener(type, listener) {
    (this.listeners[type] ||= []).push(listener);
  }

  removeEventListener(type, listener) {
    const listeners = this.listeners[type] || [];
    const index = listeners.indexOf(listener);
    if (index >= 0) listeners.splice(index, 1);
  }

  dispatch(type, event = {}) {
    for (const listener of [...(this.listeners[type] || [])]) {
      listener({ target: this, ...event });
    }
  }

  listenerCount(type) {
    return (this.listeners[type] || []).length;
  }

  querySelector(selector) {
    return findElement(this, selector);
  }
}

function findElement(root, selector) {
  const queue = [...(root.children || [])];
  while (queue.length > 0) {
    const element = queue.shift();
    if (selector.startsWith('#') && element.id === selector.slice(1)) return element;
    if (selector.startsWith('.') && element.className.split(/\s+/).includes(selector.slice(1))) return element;
    queue.push(...element.children);
  }
  return null;
}

function createElement(document, tagName, options = {}) {
  const element = new Element(tagName, document);
  if (options.id) element.id = options.id;
  if (options.className) element.className = options.className;
  if (options.hidden) element.hidden = true;
  return element;
}

function deferred() {
  let resolve;
  let reject;
  const promise = new Promise((resolvePromise, rejectPromise) => {
    resolve = resolvePromise;
    reject = rejectPromise;
  });
  return { promise, resolve, reject };
}

async function flushMicrotasks(rounds = 4) {
  for (let index = 0; index < rounds; index += 1) await Promise.resolve();
}

function createHarness() {
  const documentListeners = {};
  const initializationQueue = [];
  const initializationCalls = [];

  const document = {
    readyState: 'uninitialized',
    createElement(tagName) { return new Element(tagName, this); },
    getElementById(id) {
      return findElement({ children: [this.head, this.body] }, `#${id}`);
    },
    querySelector(selector) {
      return findElement({ children: [this.head, this.body] }, selector);
    },
    addEventListener(type, listener) { (documentListeners[type] ||= []).push(listener); },
    removeEventListener(type, listener) {
      const listeners = documentListeners[type] || [];
      const index = listeners.indexOf(listener);
      if (index >= 0) listeners.splice(index, 1);
    },
  };
  document.head = createElement(document, 'head');
  document.body = createElement(document, 'body');
  document.documentElement = createElement(document, 'html');

  const container = createElement(document, 'div', { id: 'unity-container' });
  const initialCanvas = createElement(document, 'canvas', { id: 'unity-canvas' });
  const loading = createElement(document, 'div', { id: 'unity-loading' });
  const loadingLabel = createElement(document, 'p', { className: 'loading-label' });
  const progress = createElement(document, 'progress', { id: 'unity-progress' });
  const progressText = createElement(document, 'output', { id: 'unity-progress-text' });
  const error = createElement(document, 'div', { id: 'unity-error', hidden: true });
  const errorMessage = createElement(document, 'p', { id: 'unity-error-message' });

  loading.appendChild(loadingLabel);
  loading.appendChild(progress);
  loading.appendChild(progressText);
  error.appendChild(errorMessage);
  container.appendChild(initialCanvas);
  container.appendChild(loading);
  container.appendChild(error);
  document.body.appendChild(container);

  const warnings = [];
  const window = {
    document,
    console: { warn(...args) { warnings.push(args); } },
    createUnityInstance(canvas, config, onProgress) {
      const initializer = initializationQueue.shift();
      assert.equal(typeof initializer, 'function', 'the test queued a Unity initializer');
      initializationCalls.push({ canvas, config, onProgress });
      return initializer({ canvas, config, onProgress });
    },
  };
  vm.runInNewContext(fs.readFileSync('assets/js/preview-3d-host.js', 'utf8'), { window });

  return {
    document,
    error,
    errorMessage,
    host: window.RYOTEI_HOST_3D,
    initialCanvas,
    initializationCalls,
    initializationQueue,
    progressText,
    warnings,
    scripts() { return document.head.children.filter((child) => child.tagName === 'SCRIPT'); },
  };
}

(async () => {
  const harness = createHarness();
  assert.equal(harness.host.getState(), 'idle', 'host starts idle');
  const firstInitialization = deferred();
  const firstQuit = deferred();
  let firstQuitCalls = 0;
  const firstInstance = {
    Quit() {
      firstQuitCalls += 1;
      return firstQuit.promise;
    },
  };
  harness.initializationQueue.push(() => firstInitialization.promise);

  const firstMount = harness.host.mount(harness.document);
  assert.equal(harness.host.mount(harness.document), firstMount, 'mount is idempotent while loading');
  assert.equal(harness.scripts().length, 1, 'double mount inserts one loader script');
  assert.equal(harness.initialCanvas.listenerCount('webglcontextlost'), 1, 'mount registers one canvas listener');

  harness.scripts()[0].onload();
  await flushMicrotasks();
  assert.equal(harness.initializationCalls.length, 1, 'double mount initializes Unity once');

  const { onProgress } = harness.initializationCalls[0];
  onProgress(0.251);
  const writesAt25Percent = harness.progressText.textWriteCount;
  onProgress(0.252);
  assert.equal(
    harness.progressText.textWriteCount,
    writesAt25Percent,
    'repeated rounded progress does not rewrite the live-region text',
  );

  firstInitialization.resolve(firstInstance);
  assert.equal(await firstMount, firstInstance, 'mount resolves with the Unity instance');
  assert.equal(harness.host.getState(), 'ready', 'successful initialization reaches ready');

  const firstCanvas = harness.initialCanvas;
  const unmountPromise = harness.host.unmount();
  await flushMicrotasks();
  assert.equal(firstQuitCalls, 1, 'unmount calls Unity Quit once');
  assert.ok(firstCanvas.parentNode, 'canvas remains mounted while Quit is pending');
  assert.equal(harness.host.getState(), 'ready', 'unmount waits for Quit before resetting state');

  firstQuit.resolve();
  await unmountPromise;
  assert.equal(firstCanvas.parentNode, null, 'canvas is removed after Quit resolves');
  assert.equal(firstCanvas.listenerCount('webglcontextlost'), 0, 'unmount removes the listener from its registered canvas');
  assert.equal(harness.scripts().length, 0, 'unmount removes the loader script');
  assert.equal(harness.host.getState(), 'idle', 'unmount restores idle state');

  const secondInstance = { Quit: () => Promise.resolve() };
  harness.initializationQueue.push(() => Promise.resolve(secondInstance));
  const remountPromise = harness.host.mount(harness.document);
  const secondCanvas = harness.document.getElementById('unity-canvas');
  assert.notEqual(secondCanvas, firstCanvas, 'remount creates a fresh canvas');
  assert.equal(secondCanvas.listenerCount('webglcontextlost'), 1, 'remount registers exactly one canvas listener');
  assert.equal(harness.scripts().length, 1, 'remount creates one fresh loader script');
  harness.scripts()[0].onload();
  assert.equal(await remountPromise, secondInstance, 'remount creates a fresh Unity instance');
  assert.equal(harness.initializationCalls.length, 2, 'mount-unmount-mount initializes Unity twice without reuse');
  await harness.host.unmount();

  const rejectionHarness = createHarness();
  rejectionHarness.initializationQueue.push(() => Promise.reject(new Error('fake initialization failure')));
  const rejectedMount = rejectionHarness.host.mount(rejectionHarness.document);
  rejectionHarness.scripts()[0].onload();
  assert.equal(await rejectedMount, null, 'initialization rejection is handled without escaping mount');
  assert.equal(rejectionHarness.host.getState(), 'error', 'initialization rejection reaches error');
  assert.equal(rejectionHarness.error.hidden, false, 'initialization rejection exposes error UI');
  assert.equal(rejectionHarness.errorMessage.textContent, 'fake initialization failure');
  await rejectionHarness.host.unmount();

  const loaderFailureHarness = createHarness();
  const failedLoaderMount = loaderFailureHarness.host.mount(loaderFailureHarness.document);
  const failedLoaderScript = loaderFailureHarness.scripts()[0];
  failedLoaderScript.onerror();
  assert.equal(await failedLoaderMount, null, 'loader failure is handled without escaping mount');
  assert.equal(loaderFailureHarness.host.getState(), 'error', 'loader failure reaches error');
  assert.equal(loaderFailureHarness.error.hidden, false, 'loader failure exposes error UI');
  assert.equal(
    loaderFailureHarness.errorMessage.textContent,
    'Unity loaderの読み込みに失敗しました。',
    'loader failure reports the approved message',
  );
  assert.equal(failedLoaderScript.parentNode, null, 'failed loader script is removed');

  const loaderRetryInstance = { Quit: () => Promise.resolve() };
  loaderFailureHarness.initializationQueue.push(() => Promise.resolve(loaderRetryInstance));
  const loaderRetryMount = loaderFailureHarness.host.mount(loaderFailureHarness.document);
  await flushMicrotasks(8);
  const loaderRetryScript = loaderFailureHarness.scripts()[0];
  assert.notEqual(loaderRetryScript, failedLoaderScript, 'retry inserts a fresh loader script');
  assert.equal(failedLoaderScript.parentNode, null, 'retry does not reinsert the failed loader script');
  loaderRetryScript.onload();
  assert.equal(await loaderRetryMount, loaderRetryInstance, 'retry after loader failure can reach ready');
  await loaderFailureHarness.host.unmount();

  const pendingLoaderHarness = createHarness();
  const unhandledRejections = [];
  const handleUnhandledRejection = (reason) => unhandledRejections.push(reason);
  process.on('unhandledRejection', handleUnhandledRejection);
  try {
    const pendingLoaderMount = pendingLoaderHarness.host.mount(pendingLoaderHarness.document);
    const pendingLoaderCanvas = pendingLoaderHarness.initialCanvas;
    const pendingLoaderScript = pendingLoaderHarness.scripts()[0];
    await pendingLoaderHarness.host.unmount();
    assert.equal(await pendingLoaderMount, null, 'cancelled loader mount resolves without throwing');
    await new Promise((resolve) => setImmediate(resolve));
    assert.equal(pendingLoaderHarness.host.getState(), 'idle', 'loader cancellation leaves host idle');
    assert.equal(pendingLoaderCanvas.parentNode, null, 'loader cancellation removes the canvas');
    assert.equal(pendingLoaderScript.parentNode, null, 'loader cancellation removes the script');
    assert.deepEqual(unhandledRejections, [], 'loader cancellation does not emit an unhandled rejection');
  } finally {
    process.removeListener('unhandledRejection', handleUnhandledRejection);
  }

  const staleInitializationHarness = createHarness();
  const staleInitialization = deferred();
  let staleInitializationQuitCalls = 0;
  const staleInitializationInstance = {
    Quit() {
      staleInitializationQuitCalls += 1;
      return Promise.resolve();
    },
  };
  staleInitializationHarness.initializationQueue.push(() => staleInitialization.promise);
  const staleInitializationMount = staleInitializationHarness.host.mount(staleInitializationHarness.document);
  const staleInitializationCanvas = staleInitializationHarness.initialCanvas;
  const staleInitializationScript = staleInitializationHarness.scripts()[0];
  staleInitializationScript.onload();
  await flushMicrotasks();
  await staleInitializationHarness.host.unmount();
  assert.equal(staleInitializationHarness.host.getState(), 'idle', 'unmount during initialization reaches idle');
  assert.equal(staleInitializationCanvas.parentNode, null, 'unmount removes the initializing canvas');
  assert.equal(staleInitializationScript.parentNode, null, 'unmount removes the initializing loader script');
  staleInitialization.resolve(staleInitializationInstance);
  assert.equal(await staleInitializationMount, null, 'stale initialization does not become ready');
  assert.equal(staleInitializationQuitCalls, 1, 'stale initialization result is quit exactly once');
  assert.equal(staleInitializationHarness.host.getState(), 'idle', 'stale resolution keeps host idle');
  assert.equal(
    staleInitializationHarness.document.getElementById('unity-canvas'),
    null,
    'stale resolution does not reinsert its canvas',
  );

  const quitFailureHarness = createHarness();
  const quitFailureInstance = { Quit: () => Promise.reject(new Error('quit failed')) };
  quitFailureHarness.initializationQueue.push(() => Promise.resolve(quitFailureInstance));
  const quitFailureMount = quitFailureHarness.host.mount(quitFailureHarness.document);
  const quitFailureCanvas = quitFailureHarness.initialCanvas;
  const quitFailureScript = quitFailureHarness.scripts()[0];
  quitFailureScript.onload();
  await quitFailureMount;
  await quitFailureHarness.host.unmount();
  assert.equal(quitFailureHarness.host.getState(), 'idle', 'Quit rejection still reaches idle');
  assert.equal(quitFailureCanvas.parentNode, null, 'Quit rejection still removes the canvas');
  assert.equal(quitFailureScript.parentNode, null, 'Quit rejection still removes the loader script');
  assert.equal(quitFailureHarness.warnings.length, 1, 'Quit rejection emits one warning');
  assert.equal(
    quitFailureHarness.warnings[0][0],
    'Unity instance cleanup failed.',
    'Quit rejection warning uses the approved message',
  );

  const fatalInitializationHarness = createHarness();
  let fatalInitializationQuitCalls = 0;
  const fatalInitializationInstance = {
    Quit() {
      fatalInitializationQuitCalls += 1;
      return Promise.resolve();
    },
  };
  fatalInitializationHarness.initializationQueue.push(({ config }) => {
    config.showBanner('fatal during initialization', 'error');
    return Promise.resolve(fatalInitializationInstance);
  });
  const fatalInitializationMount = fatalInitializationHarness.host.mount(fatalInitializationHarness.document);
  fatalInitializationHarness.scripts()[0].onload();
  assert.equal(
    await fatalInitializationMount,
    null,
    'mount resolves null when initialization reports a fatal banner',
  );
  assert.equal(fatalInitializationHarness.host.getState(), 'error', 'fatal initialization remains error');
  await fatalInitializationHarness.host.unmount();
  assert.equal(fatalInitializationQuitCalls, 1, 'fatal initialization instance remains available for cleanup');

  const retryHarness = createHarness();
  let staleQuitCalls = 0;
  const staleInstance = {
    Quit() {
      staleQuitCalls += 1;
      return Promise.resolve();
    },
  };
  const replacementInstance = { Quit: () => Promise.resolve() };
  retryHarness.initializationQueue.push(() => Promise.resolve(staleInstance));
  const readyMount = retryHarness.host.mount(retryHarness.document);
  const staleCanvas = retryHarness.initialCanvas;
  const staleScript = retryHarness.scripts()[0];
  staleScript.onload();
  await readyMount;

  const fatalConfig = retryHarness.initializationCalls[0].config;
  fatalConfig.showBanner('fatal Unity failure', 'error');
  assert.equal(retryHarness.host.getState(), 'error', 'fatal Unity banner reaches error with a live instance');
  assert.equal(retryHarness.error.hidden, false, 'fatal Unity banner exposes error UI');

  retryHarness.initializationQueue.push(() => Promise.resolve(replacementInstance));
  const retryMount = retryHarness.host.mount(retryHarness.document);
  await flushMicrotasks(8);
  const replacementCanvas = retryHarness.document.getElementById('unity-canvas');
  const replacementScript = retryHarness.scripts()[0];
  assert.equal(staleQuitCalls, 1, 'retry from error quits the surviving stale instance');
  assert.notEqual(replacementCanvas, staleCanvas, 'retry from error creates a new canvas');
  assert.notEqual(replacementScript, staleScript, 'retry from error creates a new loader script');
  assert.equal(staleCanvas.parentNode, null, 'retry removes the stale canvas');
  assert.equal(staleScript.parentNode, null, 'retry removes the stale loader script');
  assert.equal(retryHarness.error.hidden, true, 'retry hides the old error UI while loading');
  replacementScript.onload();
  assert.equal(await retryMount, replacementInstance, 'retry initializes a replacement Unity instance');
  assert.equal(retryHarness.host.getState(), 'ready', 'successful retry returns to ready');
  await retryHarness.host.unmount();

  console.log('preview-3d host lifecycle test: PASS');
})().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
