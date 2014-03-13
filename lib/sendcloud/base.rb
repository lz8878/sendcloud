module Sendcloud
  class Base
    # Options taken from
    # http://sendcloud.sohu.com/sendcloud/api-doc/web-api-ref
    # https://sendcloud.sohu.com/webapi/<模块>.<动作>.<格式>
    
    def initialize options
      Sendcloud.sendcloud_host = options.fetch(:sendcloud_host, 'sendcloud.sohu.com')
      Sendcloud.protocol       = options.fetch(:protocol, 'https')
      Sendcloud.api_user       = options.fetch(:api_user) { raise ArgumentError.new(":api_user is a required argument to initialize Sendcloud") if Sendcloud.api_user.nil? }
      Sendcloud.api_key        = options.fetch(:api_key) { raise ArgumentError.new(":api_key is a required argument to initialize Sendcloud") if Sendcloud.api_key.nil? }
    end
    
    
    def base_url mod = 'stats', motion = 'get'
      "#{Sendcloud.protocol}://#{Sendcloud.sendcloud_host}/webapi/#{mod}.#{motion}.json"
    end
    
    def mail
      Sendcloud::Mail.new(self)
    end
    
    def stats
      Sendcloud::Stats.new(self)
    end
    
    def unsubscribes
      Sendcloud::Unsubscribe.new(self)
    end
    
    def bounces
      Sendcloud::Bounce.new(self)
    end
    
  end
  
  class << self
    attr_accessor :sendcloud_host, :protocol, :api_user, :api_key, :data_type
    def configure
      yield self
      true
    end
    alias :config :configure
  end
  
  def self.submit(method, url, parameters={})
    begin
      parameters[:api_user] = Sendcloud.api_user
      parameters[:api_key] = Sendcloud.api_key
      parameters = {:params => parameters} if method == :get
      return JSON.parse(RestClient.send(method, url, parameters))
    rescue => e
      raise e
    end
  end
end