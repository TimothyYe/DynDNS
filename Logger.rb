require 'logger'

module Logger
	Log = Logger.new(File.expand_path('./DynDNS.log'), 'weekly')
end
