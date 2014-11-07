'use strict';

var sandbox = require('sandboxed-module');

module.exports = function(window) {
  return sandbox.require('hammerjs', {
    globals: {
      window: window,
      document: window.document
    }
  });
};
