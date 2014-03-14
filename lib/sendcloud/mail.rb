module Sendcloud
  class Mail
    def initialize(sendcloud)
       @sendcloud = sendcloud
    end
    
    def send_email(parameters = {})
      # options:
      # :from, :to, :subject, :html, :fromname
      # :cc, :bcc, :replyto, :use_maillist, :headers, :x_smtpapi, :resp_email_id, :gzip_compress
      # :attachment
      # :attachments
      Sendcloud.submit :post, mail_url, parameters
    end
    
    def send_template(parameters = {})
      # options: 
      # :template_invoke_name, :subject, :from, :fromname, :substitution_vars
      Sendcloud.submit :post, mail_url('send_template'), parameters
    end
    
    private
    def mail_url(motion = 'send')
      @sendcloud.base_url('mail', motion)
    end
  end
end