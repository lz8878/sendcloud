require "action_mailer"
require "sendcloud/version"
require "rest-client"
require "json"
require "multimap"

require "sendcloud/base"
require "sendcloud/bounce"
require "sendcloud/mail"
require "sendcloud/stats"
require "sendcloud/unsubscribe"

def Sendcloud(options = {})
  options[:api_user] = Sendcloud.api_user if Sendcloud.api_user
  options[:api_key] = Sendcloud.api_key if Sendcloud.api_key
  Sendcloud::Base.new(options)
end


module Sendcloud
  
  class DeliveryMethod
    
    def initialize(settings)
      Sendcloud.api_user       = settings.fetch(:api_user) { raise ArgumentError.new(":api_user is a required argument to initialize Sendcloud") if Sendcloud.api_user.nil? }
      Sendcloud.api_key        = settings.fetch(:api_key) { raise ArgumentError.new(":api_key is a required argument to initialize Sendcloud") if Sendcloud.api_key.nil? }
    end
    
    def deliver!(mail)
      sendcloud = Sendcloud()
      begin
        result = sendcloud.mail.send_email({
          :to => mail.destinations.join(';'),
          :html => mail.body.encoded,
          :subject => mail.subject,
          :from => mail.from_addrs.first,
          :fromname => mail[:fromname].to_s
        })
        puts "Sendcloud send email result --------->\n#{result}"
      rescue =>e
        raise e
      end
    end 
      
  end
  
  ActionMailer::Base.add_delivery_method :sendcloud, Sendcloud::DeliveryMethod
end
