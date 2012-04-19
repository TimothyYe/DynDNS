# Dynamic DNS script for DNSPod
# Written by Timothy
# Blog http://www.xiaozhou.net
# Create Date: 2012.4.4
# Last Update: 2012.4.19

# Define required blocks

require 'net/http'
require 'net/https'
require 'open-uri'
require 'json'

# Defination of static strings

$login_email = "abc@abc.com"
$login_password = "123456"

$your_Domain = "ourvps.com"
$your_SubDomain = "transmission"

$format = "json"
$lang = "en"

$userAgent = "DynDNS/0.1 (yexiaozhou2003@gmail.com)"
$postFormat = "login_email=" + $login_email + "&login_password=" + $login_password + "&format=" + $format + "&lang=" + $lang

$getIpUrl = "http://members.3322.org/dyndns/getip"

# Defination of functions
def PostRequest(functionAddr, postContent)
  http = Net::HTTP.new("dnsapi.cn", 443)
  http.use_ssl = true
  headers = {
      'Content-Type' => 'application/x-www-form-urlencoded',
      'User-Agent' => $userAgent
  }

  #puts postContent
  response = http.post2(functionAddr, postContent, headers)

  #Output response for debug
  #puts response.code
  #puts response.message
  #puts response.body

  return response
end

def GetPublicIPAddr()
  return open($getIpUrl).read
end

def GetAPIVersion()
  response = PostRequest("/Info.Version", $postFormat)
  content = JSON.parse(response.body)

  if(content['status']['code'] == "1")
    return content['status']['message']
  else
    puts "Failed to get API version!"
  end
end

def GetDomainInfo()
  response = PostRequest("/Domain.List", $postFormat + "&type=all&offset=0&length=20")
  content = JSON.parse(response.body)
  domainInfo = Hash.new

  if(content['status']['code'] == "1")
    content['domains'].each { |obj|
      domainInfo[obj['name']] = obj['id']
    }
  else
    puts "Failed to get domain id..."
  end

  return domainInfo
end

def GetSubDomainIP(domainId, subDomain)
  response = PostRequest("/Record.List", $postFormat + "&domain_id=" + domainId.to_s() + "&offset=0&length=30")
  content = JSON.parse(response.body)
  subDomains = Hash.new

  if(content['status']['code'] == "1")
    content['records'].each { |obj|
      subDomains[obj['name']] = obj['id']
    }
  else
    puts "Failed to get sub-domain records..."
  end

  return subDomains[subDomain]
end

# Execute section

#puts GetPublicIPAddr()
puts GetAPIVersion()
result = GetDomainInfo()
puts result
result1 = GetSubDomainIP(result[$your_Domain], $your_SubDomain)
puts result1