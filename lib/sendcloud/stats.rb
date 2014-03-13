module Sendcloud
  class Stats
    def initialize sendcloud, api_user, api_key, data_type
      @sendcloud = sendcloud
      @api_user = api_user
      @api_key = api_key
      @data_type = data_type
    end
    
    def get_categories
      get({ :list => true })['categories']||[]
    end
    
    def get parameters = {}
      # options:
      # :days, :start_date, :end_date, :list, :category, :aggregate
      Sendcloud.submit :get, stats_url, parameters
    end
    
    private
    def stats_url
      "#{@sendcloud.base_url}/stats.get.#{@data_type}?api_user=#{@api_user}&api_key=#{@api_key}"
    end
  end
end
