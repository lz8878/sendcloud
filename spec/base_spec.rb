require 'spec_helper'

describe Sendcloud::Base do
  it "should raise an error if the api_user and the api_key have not been set" do
    expect do
      Sendcloud()
    end.to raise_error ArgumentError
  end
  
  it "should raise an error if the api_user has not been set" do
    expect do
      Sendcloud({:api_key => "api-key"})
    end.to raise_error ArgumentError
  end
  
  it "should raise an error if the api_key has not been set" do
    expect do
      Sendcloud({:api_user => "api-user"})
    end.to raise_error ArgumentError
  end
  
  it "can be called directly if the api_key and api_user have been set via Sendcloud.configure" do
    Sendcloud.config do |c| 
      c.api_user = "api-user"
      c.api_key = "api-key"
    end
    
    expect do
      Sendcloud()
    end.not_to raise_error()
  end
  
  it "can be instanced with the api_key and api_user" do
    expect do
      Sendcloud({:api_key => "api-key", :api_user => 'api-user'})
    end.not_to raise_error()
  end
  
  describe "Sendcloud.new" do
    it "Sendcloud() method should return a new Sendcloud object" do
      sendcloud = Sendcloud({:api_key => "api-key", :api_user => 'api-user'})
      sendcloud.should be_kind_of Sendcloud::Base
    end
  end
  
  describe "internal helper methods" do
    before :each do
      @sendcloud = Sendcloud({:api_key => "api-key", :api_user => 'api-user'})
    end
    describe "Sendcloud#base_url" do
      it "the base_url should return https://sendcloud.sohu.com/webapi/stats.get.json" do
        @sendcloud.base_url.should eq("https://#{Sendcloud.sendcloud_host}/webapi/stats.get.json")
      end
    end
  end
  
  describe "configuration" do
    describe "default setting" do
      it "shoud use https by default" do
        Sendcloud.protocol.should eq("https")
      end
      it "sendcloud_host is 'sendcloud.sohu.com'" do
        Sendcloud.sendcloud_host.should eq("sendcloud.sohu.com")
      end
    end
    
    describe "setting configurations" do
      before :each do
        Sendcloud.config do |c|
          c.protocol = 'https'
          c.sendcloud_host = 'sendcloud.sohu.com'
          c.api_key = 'set-sendcloud-api-key'
          c.api_user = 'JingLi@gmail.com'
          c.data_type = 'xml'
        end
      end
      
      it "allows me to set my API user attribute" do
        Sendcloud.api_user.should eq('JingLi@gmail.com')
      end
      it "allows me to set my API key attribute" do
        Sendcloud.api_key.should eq('set-sendcloud-api-key')
      end
      it "allows me to set the protocol attribute" do
        Sendcloud.protocol.should eq('https')
      end
      it "allows me to set the sendcloud_host attribute" do
        Sendcloud.sendcloud_host.should eq('sendcloud.sohu.com')
      end
      it "allows me to set the data_type attribute" do
        Sendcloud.data_type.should eq('xml')
      end
    end
  end
  
end