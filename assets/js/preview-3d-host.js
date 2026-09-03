(function exposePreview3dHost(global) {
  'use strict';

  const state = 'idle';

  global.RYOTEI_HOST_3D = {
    mount() {
      return null;
    },
    unmount() {
      return Promise.resolve();
    },
    getState() {
      return state;
    },
  };
})(window);
