# Dynamic DNS scripts for DNSPod
# Written by Timothy
# Blog http://www.xiaozhou.net
# Create Date: 2012.4.4
# Last Update: 2012.4.19

# Define required blocks

require 'net/http'
require 'net/https'
require 'open-uri'
require 'json'
require './DNSPodHelper.rb'


# Defination of static strings

$login_email = "abc@abc.com"
$login_password = "123456"

$your_Domain = "ourvps.com"
$your_SubDomain = "transmission"

# Execute section

helper = DNSPodHelper.instance
helper.SetUserInfo('abc@gmail.com', '123')

puts helper.GetPublicIPAddr()

#puts GetAPIVersion()
#result = GetDomainInfo()
#puts result
#result1 = GetSubDomainIP(result[$your_Domain], $your_SubDomain)
#puts result1

