require "action_mailer"
require "rest-client"
require "json"
require "logger"

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

      deliver_log(mail)

      begin
        result = sendcloud.mail.send_email({
          :to => mail.destinations.join(';'),
          :html => mail.body.encoded,
          :subject => mail.subject,
          :from => mail.from_addrs.first,
          :fromname => mail[:fromname].to_s
        })
        deliver_result_log(result)
      rescue =>e
        deliver_error(e)
        raise e
      end
    end

    def deliver_log(mail)
      return unless Sendcloud.log
      Sendcloud.log.info "Subject: --------->#{mail.subject}"
      Sendcloud.log.info "To: --------->#{mail.destinations.join(';')}"
      Sendcloud.log.info "From: --------->#{mail.from_addrs.first}"
    end

    def deliver_result_log(result)
      return unless Sendcloud.log
      Sendcloud.log.info "Sendcloud deliver result: --------->#{result}"
    end

    def deliver_error(e)
      return unless Sendcloud.log
      Sendcloud.log.fatal("Sendcloud error: ---------> #{e.to_s}")
    end
  end
  
  ActionMailer::Base.add_delivery_method :sendcloud, Sendcloud::DeliveryMethod
end
