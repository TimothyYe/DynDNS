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

$login_email = "abc@gmail.com"
$login_password = "abc"

$your_Domain = "ourvps.com"
$your_SubDomain = "transmission"

# Execute section

helper = DNSPodHelper.instance
helper.SetUserInfo($login_email, $login_password)

publicIP = helper.GetPublicIPAddr()

#puts GetAPIVersion()
domains = helper.GetDomainInfo()
#puts result

subDomainIP = helper.GetSubDomainIP(domains[$your_Domain], $your_SubDomain)

if(subDomainIP != publicIP)
  puts "Public IP(#{publicIP}) is different from sub-domain IP(#{subDomainIP}), need to update!"
end

