# Dynamic DNS scripts for DNSPod
# Written by Timothy
# Blog http://www.xiaozhou.net
# Create Date: 2012.4.4
# Last Update: 2012.4.19

# Define required blocks

require './DNSPodHelper'
require './Logger'
require 'daemons'

# Execute section
Daemons.run_proc("DynDNS") do

        puts 'DynDNS daemon starting...'
	helper = DNSPodHelper.instance

	loop {

		begin

		publicIP = helper.GetPublicIPAddr
		domains = helper.GetDomainInfo

		subDomain = helper.GetSubDomain(domains[DNSPodHelper::CONFIG["your_Domain"]], DNSPodHelper::CONFIG["your_SubDomain"])

		Logger.instance.log("Public IP is:#{publicIP.strip}, Sub-domain IP is:#{subDomain['value'].strip}")

		if(subDomain['value'].strip != publicIP.strip)
		Logger.instance.log("Public IP(#{publicIP.strip}) is different from sub-domain IP(#{subDomain['value'].strip}), need to update!")
		helper.UpdateSubDomainIP(domains[DNSPodHelper::CONFIG["your_Domain"]], subDomain['id'], DNSPodHelper::CONFIG["your_SubDomain"], publicIP.strip)
		end

		rescue => e
			Logger.instance.log(e.class.to_s() + " occurs, failed to finish the process! Will try next time!")
		end

		sleep(1*60*5)
	}
end

