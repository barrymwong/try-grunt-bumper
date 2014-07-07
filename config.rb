# All gems that are required for this extension to work should go here.
# These are the requires you would normally put in your config.rb file
# By default, you should always included Compass. Do not include your
#	extension.
require 'compass'
# require 'otcore' # is required, but won't work ad hoc

# This tells Compass what your Compass extension is called, and where to find
#	its files
# Replace 'extension' with the name of your extension. Spaces allowed.
extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('gctheme', :path => extension_path)

# Version and date of version for your Compass extension.
# Replace Extension with the name of your extension
#	Letters, numbers, and underscores only
#	Version is a number. If a version contains alphas, it will be created as
#	a prerelease version
#	Date is in the form of YYYY-MM-DD
module Gctheme
	VERSION = "1.2.18"
	DATE = "2014-07-07"
end

# This is where any custom SassScript should be placed. The functions will be
#	available on require of your extension without the need for users to import
#	any partials. Uncomment below.

module Sass::Script::Functions
	def prettify(num)
		num.to_i == num ? num.to_i : num
	end
	def strip_units(num)
		newnum = self.prettify(num.to_s.to_f)
		# puts newnum
		return Sass::Script::Number.new(newnum)
	end
	def get_unit(num)
		unit = num.to_s.gsub(/[^a-z%]/, '')
		# puts unit
		return Sass::Script::String.new(unit)
	end
end