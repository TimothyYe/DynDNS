require 'logger'

module Utility
	Log = Logger.new(File.expand_path('./DynDNS.log'), 'weekly')
end
