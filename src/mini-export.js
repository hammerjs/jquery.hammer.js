// AMD
if(typeof define == 'function' && define.amd) {
  define(setupPlugin);
}

else {
  setupPlugin(window.Hammer, window.jQuery || window.Zepto);
}