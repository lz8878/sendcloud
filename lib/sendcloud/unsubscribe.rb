module Sendcloud
  class Unsubscribe
    
    def initialize sendcloud
      @sendcloud = sendcloud
    end
    
    # options:
    # :days, :start_date, :end_date, :start, :limit, :email
    def list paramters = {}
      Sendcloud.submit :get, unsubscribe_url('get'), paramters
    end
    
    def add email
      Sendcloud.submit :post, unsubscribe_url('add'), {:email => email}
    end
    
    # options:
    # :start_date, :end_date, :email
    def remove paramters = {}
      Sendcloud.submit :post, unsubscribe_url('delete'), paramters
    end
    
    private
    
    def unsubscribe_url motion = 'get'
      @sendcloud.base_url('subscribes', motion)
    end
  end
end