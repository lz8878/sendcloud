module Sendcloud
  class Unsubscribe
    
    def initialize(sendcloud)
      @sendcloud = sendcloud
    end
    
    # options:
    # :days, :start_date, :end_date, :start, :limit, :email
    def list(parameters = {})
      Sendcloud.submit :get, unsubscribe_url('get'), parameters
    end
    
    def add email
      Sendcloud.submit :post, unsubscribe_url('add'), {:email => email}
    end
    
    # options:
    # :start_date, :end_date, :email
    def remove(parameters = {})
      Sendcloud.submit :post, unsubscribe_url('delete'), parameters
    end
    
    private
    
    def unsubscribe_url(motion = 'get')
      @sendcloud.base_url('unsubscribes', motion)
    end
  end
end