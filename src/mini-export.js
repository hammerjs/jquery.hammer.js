// AMD
if(typeof define == 'function' && define.amd) {
  define(function () {

  	return setupPlugin(window.Hammer, window.jQuery || window.Zepto);
  });
}

else {
  setupPlugin(window.Hammer, window.jQuery || window.Zepto);
}