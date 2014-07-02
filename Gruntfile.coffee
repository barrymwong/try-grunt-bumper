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
			rb:
				src: ['config.rb']
				overwrite: true
				replacements: [
					from: /[0-9].[0-9].[0-9]/
					to: '<%= pkg.version %>'
				]

	grunt.loadNpmTasks 'grunt-bumper'
	grunt.loadNpmTasks 'grunt-text-replace'

	grunt.registerTask 'release', ['bumper']
	grunt.registerTask 'replacer', ['replace']