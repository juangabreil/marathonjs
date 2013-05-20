module.exports = (grunt) ->
	'use strict'

	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		meta:
			file: 'marathon'
			banner: '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
              '   <%= pkg.homepage %>\n' +
              '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
              ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */\n'
			build: 'build'
			specs: 'specs'
			reports: 'reports'

		source:
			coffee: 'src/marathon.coffee'
			specs: 'spec/marathon.coffee'

		coffee:
			source: 
				files:
					'<%=meta.build%>/<%=meta.file%>-<%=pkg.version%>/<%=meta.file%>.debug.js': '<%= source.coffee %>'
					'<%=meta.build%>/<%=meta.file%>-<%=pkg.version%>/<%=meta.specs%>/<%=meta.file%>.js': '<%= source.specs %>'

		uglify:
			options:
				compress: true
				banner: "<%= meta.banner %>"
			engine:
				files: '<%=meta.build%>/<%=meta.file%>-<%=pkg.version%>/<%=meta.file%>.js' : '<%=meta.build%>/<%=meta.file%>-<%=pkg.version%>/<%=meta.file%>.debug.js'

		jasmine:
			src: '<%=meta.build%>/<%=meta.file%>-<%=pkg.version%>/<%=meta.file%>.debug.js'
			options: 
				specs: '<%=meta.build%>/<%=meta.file%>-<%=pkg.version%>/<%=meta.specs%>/*.js'
				template : require('grunt-template-jasmine-istanbul')
				templateOptions: 
					coverage: '<%=meta.build%>/<%=meta.file%>-<%=pkg.version%>/<%=meta.reports%>/coverage.json'
					report: '<%=meta.build%>/<%=meta.file%>-<%=pkg.version%>/<%=meta.reports%>/coverage'

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-jasmine'

	grunt.registerTask 'default', ['coffee', 'uglify', 'jasmine']	