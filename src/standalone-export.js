// AMD
if(typeof define == 'function' && define.amd) {
  define(['hammerjs', 'jquery'], setupPlugin);
}

else {
  setupPlugin(window.Hammer, window.jQuery || window.Zepto);
}