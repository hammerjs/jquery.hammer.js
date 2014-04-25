module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    hammerPkg: grunt.file.readJSON 'hammer.js/package.json'

    meta:
      banner: '
/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>\n
 * <%= pkg.homepage %>\n
 *\n
 * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> <<%= pkg.author.email %>>;\n
 * Licensed under the <%= _.pluck(pkg.licenses, "type").join(", ") %> license */\n'

    concat:
      options:
        separator: '\n\n'
        banner: '<%= meta.banner %>'
      standalone: # only the plugin
        dest: 'jquery.hammer.js'
        src: [
          'src/jquery.hammer.prefix'
          'src/plugin.js'
          'src/standalone-export.js'
          'src/jquery.hammer.suffix']
      full: # hammer + plugin
        dest: 'jquery.hammer-full.js'
        src: [
          'src/jquery.hammer.prefix'
          'hammer.js/src/setup.js'
          'hammer.js/src/utils.js'
          'hammer.js/src/instance.js'
          'hammer.js/src/event.js'
          'hammer.js/src/pointerevent.js'
          'hammer.js/src/detection.js'
          'hammer.js/src/gestures/*.js'
          'src/hammer-export.js' # simple export

          'src/plugin.js'
          'src/full-export.js'
          'src/jquery.hammer.suffix']

    uglify:
      options:
        report: 'gzip'
        banner: '<%= meta.banner %>'
      standalone:
        options: sourceMap: 'jquery.hammer.min.map'
        files: 'jquery.hammer.min.js': ['jquery.hammer.js']
      full:
        options: sourceMap: 'jquery.hammer-full.min.map'
        files: 'jquery.hammer-full.min.js': ['jquery.hammer-full.js']

    jshint:
      options:
        jshintrc: true
      dist:
        src: ['jquery.hammer.js']

    jscs:
      src: ['src/**/*.js', 'plugins/**/*.js']
      options:
        force: true

    watch:
      scripts:
        files: ['src/*.js','hammer.js/src/**/*.js']
        tasks: ['concat','jscs']
        options:
          interrupt: true

    'string-replace':
      version:
        files:
          'jquery.hammer-full.js': 'jquery.hammer-full.js'
        options:
          replacements: [
              pattern: '{{PKG_VERSION}}'
              replacement: '<%= hammerPkg.version %>'
            ]
    connect:
      server:
        options:
          hostname: "0.0.0.0"
          port: 8000

    qunit:
      all: ['tests/**/*.html']

  # Load tasks
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-qunit'
  grunt.loadNpmTasks 'grunt-string-replace'
  grunt.loadNpmTasks 'grunt-jscs-checker'

  # Default task(s).
  grunt.registerTask 'default', ['connect','watch']
  grunt.registerTask 'test', ['jshint','jscs','connect','qunit']
  grunt.registerTask 'build', ['concat','string-replace','uglify','test']
  grunt.registerTask 'build-simple', ['concat','string-replace','uglify','jshint']
