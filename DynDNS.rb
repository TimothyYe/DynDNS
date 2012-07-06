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

loop {

	begin
	publicIP = helper.GetPublicIPAddr

	#puts GetAPIVersion()
	domains = helper.GetDomainInfo
	#puts result

	subDomain = helper.GetSubDomain(domains[$your_Domain], $your_SubDomain)

	#puts "Public IP is:#{publicIP.strip}, Sub-domain IP is:#{subDomain['value'].strip}"
	Logger.instance.log("Public IP is:#{publicIP.strip}, Sub-domain IP is:#{subDomain['value'].strip}")

	if(subDomain['value'].strip != publicIP.strip)
	#puts "Public IP(#{publicIP.strip}) is different from sub-domain IP(#{subDomain['value'].strip}), need to update!"
  	Logger.instance.log("Public IP(#{publicIP.strip}) is different from sub-domain IP(#{subDomain['value'].strip}), need to update!")
  	helper.UpdateSubDomainIP(domains[$your_Domain], subDomain['id'], $your_SubDomain, publicIP.strip)
	end

	rescue => e
		#puts e.class.to_s() + " occurs, failed to finish the process! Will try next time!"
		Logger.instance.log(e.class.to_s() + " occurs, failed to finish the process! Will try next time!")
	end

	sleep 300
}

