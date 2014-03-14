module Sendcloud
  class Stats
    def initialize sendcloud
      @sendcloud = sendcloud
    end
    
    def get_categories
      get({ :list => true })
    end
    
    def get(parameters = {})
      # options:
      # :days, :start_date, :end_date, :list, :category||:category[], :aggregate
      Sendcloud.submit :get, stats_url, parameters
    end
    
    private
    def stats_url(motion = 'get')
      @sendcloud.base_url('stats', motion)
    end
  end
end
