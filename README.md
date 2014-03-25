jquery.hammer.js
================

[![Build Status](https://travis-ci.org/EightMedia/jquery.hammer.js.png)](https://travis-ci.org/EightMedia/jquery.hammer.js/)


jQuery plugin for [Hammer.js](https://github.com/EightMedia/hammer.js)

Since version 1.0.6 it is seperated from the main lib, and lives in this repository. 
It still needs the main library to be included, but a combined version is on its way. :beer:


## Usage

````js
var hammer_options = {};
$("#element")
  .hammer(hammer_options)
  .on("swipeleft", function(ev) { console.log(ev); });
````

The instance is added to the element, you can find it at `$("#element").data("hammer")`. If the element has a Hammer instance, you can only change the options with the jQuery plugin. 
