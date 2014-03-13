module Sendcloud
  class Mail
    def initialize sendcloud
       @sendcloud = sendcloud
    end
    
    def send_email parameters = {}
      # options:
      # :from, :to, :subject, :html, :fromname
      # :cc, :bcc, :replyto, :use_maillist, :headers, :x_smtpapi, :resp_email_id, :gzip_compress
      # :attachment
      # :attachments
      Sendcloud.submit :post, mail_url, parameters
    end
    
    private
    def mail_url motion = 'send'
      @sendcloud.base_url('mail', motion)
    end
  end
end