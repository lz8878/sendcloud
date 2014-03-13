require "sendcloud/version"
require "rest-client"
require "json"
require "multimap"

require "sendcloud/base"
require "sendcloud/bounce"
require "sendcloud/mail"
require "sendcloud/stats"
require "sendcloud/unsubscribe"

def Sendcloud options = {}
  options[:api_user] = Sendcloud.api_user if Sendcloud.api_user
  options[:api_key] = Sendcloud.api_key if Sendcloud.api_key
  Sendcloud::Base.new options
end
