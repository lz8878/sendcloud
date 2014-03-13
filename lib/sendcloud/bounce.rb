module Sendcloud
  class Bounce
    def initialize sendcloud
      @sendcloud = sendcloud
    end
    
    # options: 
    # :days, :start_date, :end_date, :start, :limit, :email
    def list parameters = {}
      Sendcloud.submit :get, bounce_url('get'), parameters
    end
    
    def count parameters = {}
      Sendcloud.submit :get, bounce_url('count'), parameters
    end
    
    def add email
      Sendcloud.submit :post, bounce_url('add'), {:email => email}
    end
    
    # options:
    # :start_date, :end_date, :email
    def delete parameters = {}
      Sendcloud.submit :post, bounce_url('delete'), parameters
    end
    
    private
    def bounce_url motion = 'get'
      @sendcloud.base_url('bounces', motion)
    end
  end
end