module Sendcloud
  class Unsubscribe
    
    def initialize sendcloud
      @sendcloud = sendcloud
    end
    
    def find email
      Sendcloud.submit :get, unsubscribe_url('get'), email
    end
    
    def list paramters = {}
      Sendcloud.submit :get, unsubscribe_url('get'), paramters
    end
    
    def add email
      Sendcloud.submit :post, unsubscribe_url('add'), email
    end
    
    def remove email
      Sendcloud.submit :delete, unsubscribe_url('delete'), email
    end
    
    private
    
    def unsubscribe_url motion = 'get'
      @sendcloud.base_url('subscribes', motion)
    end
  end
end