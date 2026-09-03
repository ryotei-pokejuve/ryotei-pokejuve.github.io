(function exposePreview3dHost(global) {
  'use strict';

  const LOADER_URL = 'assets/3d/unity/Build/WebGL.loader.js';
  const BUILD_URL = 'assets/3d/unity/Build';
  const STREAMING_ASSETS_URL = 'assets/3d/unity/StreamingAssets';

  let state = 'idle';
  let generation = 0;
  let currentRoot = null;
  let unityInstance = null;
  let mountPromise = null;
  let unmountPromise = null;
  let loaderScript = null;
  let cancelLoader = null;
  let canvas = null;
  let removeCanvasListener = null;
  let removeAutoMountListener = null;
  let progressPercent = null;

  function findById(root, id) {
    if (!root) return null;
    if (typeof root.getElementById === 'function') return root.getElementById(id);
    if (typeof root.querySelector === 'function') return root.querySelector(`#${id}`);
    return null;
  }

  function setHidden(element, hidden) {
    if (element) element.hidden = hidden;
  }

  function setState(nextState) {
    state = nextState;

    const container = findById(currentRoot, 'unity-container');
    const loading = findById(currentRoot, 'unity-loading');
    const error = findById(currentRoot, 'unity-error');

    if (container) {
      if (container.dataset) container.dataset.state = nextState;
      if (typeof container.setAttribute === 'function') {
        container.setAttribute('aria-busy', nextState === 'loading' ? 'true' : 'false');
      }
    }

    setHidden(loading, nextState !== 'loading');
    setHidden(error, nextState !== 'error');
  }

  function describeError(error) {
    if (typeof error === 'string' && error.trim()) return error.trim();
    if (error && typeof error.message === 'string' && error.message.trim()) {
      return error.message.trim();
    }
    return '3D MODEを起動できませんでした。時間をおいて再読み込みするか、2D MODEへ戻ってください。';
  }

  function showError(error, token) {
    if (token !== generation) return;
    const message = findById(currentRoot, 'unity-error-message');
    if (message) message.textContent = describeError(error);
    setState('error');
  }

  function updateProgress(progress, token) {
    if (token !== generation || state !== 'loading') return;

    const numericProgress = Number(progress);
    const normalized = Number.isFinite(numericProgress)
      ? Math.min(1, Math.max(0, numericProgress))
      : 0;
    const percent = Math.round(normalized * 100);
    if (percent === progressPercent) return;
    progressPercent = percent;

    const progressElement = findById(currentRoot, 'unity-progress');
    const progressText = findById(currentRoot, 'unity-progress-text');

    if (progressElement) {
      progressElement.value = percent;
      progressElement.textContent = `${percent}%`;
    }
    if (progressText) progressText.textContent = `${percent}%`;
  }

  function showBanner(message, type, token) {
    if (token !== generation) return;
    if (type === 'error') {
      showError(message, token);
      return;
    }

    if (state === 'loading') {
      const loadingLabel = currentRoot && typeof currentRoot.querySelector === 'function'
        ? currentRoot.querySelector('.loading-label')
        : null;
      if (loadingLabel && message) loadingLabel.textContent = String(message);
    }
  }

  function removeNode(node) {
    if (!node) return;
    if (typeof node.remove === 'function') {
      node.remove();
    } else if (node.parentNode && typeof node.parentNode.removeChild === 'function') {
      node.parentNode.removeChild(node);
    }
  }

  function removeLoaderScript() {
    if (cancelLoader) cancelLoader();
    cancelLoader = null;

    if (loaderScript) {
      loaderScript.onload = null;
      loaderScript.onerror = null;
      removeNode(loaderScript);
    }
    loaderScript = null;
  }

  function removeCanvas() {
    if (removeCanvasListener) removeCanvasListener();
    removeCanvasListener = null;
    removeNode(canvas);
    canvas = null;
  }

  function cleanupAttemptDom() {
    removeLoaderScript();
    removeCanvas();
  }

  function getDocument(root) {
    if (root && typeof root.createElement === 'function') return root;
    if (root && root.ownerDocument && typeof root.ownerDocument.createElement === 'function') {
      return root.ownerDocument;
    }
    return global.document || null;
  }

  function createCanvas(root, token) {
    const container = findById(root, 'unity-container');
    if (!container) throw new Error('3D表示領域が見つかりません。');

    let nextCanvas = findById(root, 'unity-canvas');
    if (!nextCanvas || canvas) {
      const document = getDocument(root);
      if (!document) throw new Error('3D canvasを作成できません。');

      nextCanvas = document.createElement('canvas');
      nextCanvas.id = 'unity-canvas';
      nextCanvas.width = 1280;
      nextCanvas.height = 720;
      nextCanvas.tabIndex = -1;
      if (typeof nextCanvas.setAttribute === 'function') {
        nextCanvas.setAttribute('id', 'unity-canvas');
        nextCanvas.setAttribute('width', '1280');
        nextCanvas.setAttribute('height', '720');
        nextCanvas.setAttribute('tabindex', '-1');
        nextCanvas.setAttribute('aria-label', 'RYOTEI 3Dプレビュー');
      }

      if (typeof container.insertBefore === 'function') {
        container.insertBefore(nextCanvas, container.firstChild || null);
      } else if (typeof container.appendChild === 'function') {
        container.appendChild(nextCanvas);
      } else {
        throw new Error('3D canvasを表示領域へ追加できません。');
      }
    }

    canvas = nextCanvas;
    if (typeof canvas.addEventListener === 'function') {
      const target = nextCanvas;
      const handleContextLost = (event) => {
        if (event && typeof event.preventDefault === 'function') event.preventDefault();
        showError('WebGLコンテキストが失われました。ページを再読み込みしてください。', token);
      };
      target.addEventListener('webglcontextlost', handleContextLost);
      removeCanvasListener = () => {
        target.removeEventListener('webglcontextlost', handleContextLost);
      };
    }

    return canvas;
  }

  function loadUnityLoader(root) {
    const document = getDocument(root);
    if (!document) return Promise.reject(new Error('Unity loaderを読み込めません。'));

    const parent = document.head || document.body || document.documentElement;
    if (!parent || typeof parent.appendChild !== 'function') {
      return Promise.reject(new Error('Unity loaderの読み込み先が見つかりません。'));
    }

    return new Promise((resolve, reject) => {
      const script = document.createElement('script');
      let settled = false;

      function settle(callback, value) {
        if (settled) return;
        settled = true;
        script.onload = null;
        script.onerror = null;
        if (loaderScript === script) cancelLoader = null;
        callback(value);
      }

      script.src = LOADER_URL;
      script.async = true;
      script.onload = () => settle(resolve);
      script.onerror = () => settle(reject, new Error('Unity loaderの読み込みに失敗しました。'));

      loaderScript = script;
      cancelLoader = () => settle(reject, new Error('Unity loaderの読み込みを中止しました。'));
      parent.appendChild(script);
    });
  }

  function createConfig(token) {
    return {
      arguments: [],
      dataUrl: `${BUILD_URL}/WebGL.data.unityweb`,
      frameworkUrl: `${BUILD_URL}/WebGL.framework.js.unityweb`,
      codeUrl: `${BUILD_URL}/WebGL.wasm.unityweb`,
      streamingAssetsUrl: STREAMING_ASSETS_URL,
      companyName: 'DefaultCompany',
      productName: 'ryotei_unity',
      productVersion: '1.0',
      showBanner(message, type) {
        showBanner(message, type, token);
      },
    };
  }

  function quitInstance(instance) {
    if (!instance || typeof instance.Quit !== 'function') return Promise.resolve();
    return Promise.resolve()
      .then(() => instance.Quit())
      .catch((error) => {
        if (global.console && typeof global.console.warn === 'function') {
          global.console.warn('Unity instance cleanup failed.', error);
        }
      });
  }

  function mount(root) {
    const requestedRoot = root || global.document;

    if (unmountPromise) return unmountPromise.then(() => mount(requestedRoot));
    if (state === 'loading' && mountPromise) return mountPromise;
    if (state === 'error') return unmount().then(() => mount(requestedRoot));
    if (unityInstance) return mountPromise || Promise.resolve(unityInstance);

    currentRoot = requestedRoot;
    const token = ++generation;
    setState('loading');
    progressPercent = null;
    updateProgress(0, token);

    try {
      createCanvas(currentRoot, token);
    } catch (error) {
      showError(error, token);
      mountPromise = Promise.resolve(null);
      return mountPromise;
    }

    mountPromise = loadUnityLoader(currentRoot)
      .then(() => {
        if (token !== generation) return null;
        if (typeof global.createUnityInstance !== 'function') {
          throw new Error('Unityの初期化関数を読み込めませんでした。');
        }
        return global.createUnityInstance(canvas, createConfig(token), (progress) => {
          updateProgress(progress, token);
        });
      })
      .then((instance) => {
        if (!instance) return null;
        if (token !== generation) {
          return quitInstance(instance).then(() => null);
        }

        unityInstance = instance;
        updateProgress(1, token);
        if (state !== 'error') setState('ready');
        return state === 'error' ? null : instance;
      })
      .catch((error) => {
        if (token === generation) {
          removeLoaderScript();
          showError(error, token);
        }
        return null;
      });

    return mountPromise;
  }

  function unmount() {
    if (unmountPromise) return unmountPromise;

    generation += 1;
    removeLoaderScript();
    if (removeAutoMountListener) removeAutoMountListener();
    removeAutoMountListener = null;

    const instanceToQuit = unityInstance;
    unmountPromise = quitInstance(instanceToQuit).then(() => {
      cleanupAttemptDom();
      unityInstance = null;
      mountPromise = null;
      progressPercent = null;
      setState('idle');
      currentRoot = null;
      unmountPromise = null;
    });

    return unmountPromise;
  }

  global.RYOTEI_HOST_3D = { mount, unmount, getState: () => state };

  const document = global.document;
  if (document && document.readyState === 'loading' && typeof document.addEventListener === 'function') {
    const handleReady = () => {
      if (removeAutoMountListener) removeAutoMountListener();
      removeAutoMountListener = null;
      mount(document);
    };
    document.addEventListener('DOMContentLoaded', handleReady);
    removeAutoMountListener = () => document.removeEventListener('DOMContentLoaded', handleReady);
  } else if (document && (document.readyState === 'interactive' || document.readyState === 'complete')) {
    mount(document);
  }
})(window);
