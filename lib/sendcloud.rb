require "action_mailer"
require "rest-client"
require "json"

require "sendcloud/version"
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
    
    attr_accessor :settings
    def initialize(settings)
      self.settings = settings
    end
    
    def deliver!(mail)
      sendcloud = Sendcloud(self.settings)
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
