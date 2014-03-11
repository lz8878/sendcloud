require "sendcloud/version"
require "rest-client"
require "json"
require "multimap"

require "sendcloud/base"
require "sendcloud/message"

module Sendcloud
  # Your code goes here...
  def Sendcloud options = {}
    Sendcloud::Base.new options
  end
end
