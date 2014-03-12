require 'spec_helper'

describe Sendcloud::Stats do
  before :each do
    @sendcloud = Sendcloud({
      #:api_key  => 'api-key'
      :api_user => 'postmaster@huiyipai-test.sendcloud.org',
      :api_key  => '8wdxyIby'
    })
  end
  
  describe "category list" do
    it "should make a GET request to find category list" do
      sample_response = '{"message":"success","categories":[{"category":"postmaster@huiyipai-test.sendcloud.org"}]}';
      stats_url = @sendcloud.stats.send(:stats_url)
      Sendcloud.should_receive(:submit).with(:get, stats_url, {:list => true}).and_return(sample_response)
      @sendcloud.stats.get_categories
    end
  end
  
  describe "" do
    it "" do
      
    end
  end
end