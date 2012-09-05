#!/Users/raymond/.rvm/rubies/ruby-1.9.2-p320/bin/ruby
#
require 'test/unit'
require 'test/unit/ui/console/testrunner'
require './DNSPodHelper'

class Test_DNSHelper < Test::Unit::TestCase
	def setup
		
	end

	def test_instance
		t=DNSPodHelper.instance
		puts t.inspect
		puts t.GetPublicIPAddr
		puts t.GetAPIVersion
		#puts DNSPodHelper::CONFIG

	end
	def teardown
		
	end
end

