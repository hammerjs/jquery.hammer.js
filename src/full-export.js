// AMD
if(typeof define == 'function' && define.amd) {
    define(['jquery'], function($) {
        return setupPlugin(window.Hammer, $);
    });
} else {
    setupPlugin(window.Hammer, window.jQuery || window.Zepto);
}