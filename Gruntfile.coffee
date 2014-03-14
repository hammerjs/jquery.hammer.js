module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # meta options
    meta:
      banner: '
/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>\n
 * <%= pkg.homepage %>\n
 *\n
 * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> <<%= pkg.author.email %>>;\n
 * Licensed under the <%= _.pluck(pkg.licenses, "type").join(", ") %> license */\n'

    # concat src files
    concat:
      options:
        separator: '\n\n'
        banner: '<%= meta.banner %>'
      standalone:
        src: [
          'src/jquery.hammer.prefix'
          'src/plugin.js'
          'src/standalone-export.js'
          'src/jquery.hammer.suffix']
        dest: 'jquery.hammer.js'
      full:
        src: [
          'src/jquery.hammer.prefix'

          'hammer.js/src/core.js'
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
        dest: 'jquery.hammer-full.js'

    # minify the sourcecode
    uglify:
      options:
        report: 'gzip'
        banner: '<%= meta.banner %>'
      standalone:
        options:
          sourceMap: 'jquery.hammer.min.map'
        files:
          'jquery.hammer.min.js': ['jquery.hammer.js']
      full:
        options:
          sourceMap: 'jquery.hammer-full.min.map'
        files:
          'jquery.hammer-full.min.js': ['jquery.hammer-full.js']

    # check for optimisations and errors
    jshint:
      options:
        jshintrc: true
      dist:
        src: ['jquery.hammer.js']

    # watch for changes
    watch:
      scripts:
        files: ['src/*.js']
        tasks: ['concat']
        options:
          interrupt: true

    # simple node server
    connect:
      server:
        options:
          hostname: "0.0.0.0"
          port: 8000

    # tests
    qunit:
      all: ['tests/**/*.html']


  # Load tasks
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-qunit'


  # Default task(s).
  grunt.registerTask 'default', ['connect','watch']
  grunt.registerTask 'test', ['jshint','connect','qunit']
  grunt.registerTask 'build', ['concat','uglify','test']
  grunt.registerTask 'build-simple', ['concat','uglify','jshint']
