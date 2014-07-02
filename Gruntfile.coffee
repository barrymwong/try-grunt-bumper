module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON "package.json"
		bumper:
			options:
				files: ["package.json", "bower.json"]
				updateConfigs: ['pkg'] # array of config properties to update (with files)
				releaseBranch: false
				runTasks: true
				tasks: ["replacer"]
				add: true
				addFiles: ["."] # '.' for all files except ingored files in .gitignore
				commit: true
				commitMessage: "Release v%VERSION%"
				commitFiles: ["-a"] # '-a' for all files
				createTag: true
				tagName: "v%VERSION%"
				tagMessage: "Version %VERSION%"
				push: true
				pushTo: "origin"
				npm: false
				npmTag: "Release v%VERSION%"
				gitDescribeOptions: "--tags --always --abbrev=1 --dirty=-d"

		replace:
			configRb:
				src: ['config.rb']
				overwrite: true
				replacements: [
					from: /"[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}"/
					to: '<%= pkg.version %>'
				,
					from: /"[0-9]{2,4}-[0-9]{1,2}-[0-9]{1,2}"/
					to: "<%= grunt.template.today('yyyy-mm-dd') %>"
				]

	grunt.loadNpmTasks 'grunt-bumper'
	grunt.loadNpmTasks 'grunt-text-replace'

	# $ grunt bumper
	# >> "v0.0.2"
	# $ grunt bumper:minor
	# >> "v0.1.0"
	# $ grunt bumper:major
	# >> "v1.0.0"

	grunt.registerTask 'replacer', ['replace']