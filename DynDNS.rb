# Dynamic DNS scripts for DNSPod
# Written by Timothy
# Blog http://www.xiaozhou.net
# Create Date: 2012.4.4
# Last Update: 2012.4.19

# Define required blocks

require './DNSPodHelper'
require './Logger'
require './Config'

# Execute section

helper = DNSPodHelper.instance
helper.SetUserInfo($login_email, $login_password)

publicIP = helper.GetPublicIPAddr()

#puts GetAPIVersion()
domains = helper.GetDomainInfo()
#puts result

subDomainIP = helper.GetSubDomainIP(domains[$your_Domain], $your_SubDomain)

puts "Public IP is:#{publicIP.strip}, Sub-domain IP is:#{subDomainIP.strip}"
Logger.instance.log("Public IP is:#{publicIP.strip}, Sub-domain IP is:#{subDomainIP.strip}")

if(subDomainIP.strip != publicIP.strip)
  puts "Public IP(#{publicIP}) is different from sub-domain IP(#{subDomainIP}), need to update!"
  Logger.instance.log("Public IP(#{publicIP}) is different from sub-domain IP(#{subDomainIP}), need to update!")
end

