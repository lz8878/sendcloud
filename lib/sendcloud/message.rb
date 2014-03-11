module Sendcloud
  class Message
    def initialize sendcloud
       @sendcloud = sendcloud
    end
    
    def send_email parameters = {}
      # options:
      # :from, :to, :subject, :html, :fromname
      # :cc, :bcc, :replyto, :use_maillist, :headers, :x_smtpapi, :resp_email_id, :gzip_compress
      # :attachment
      # :attachments
      Sendcloud.submit :post, message_url, parameters
    end
    
    private
    def message_url
      "#{@sendcloud.base_url}/message.send"
    end
  end
end