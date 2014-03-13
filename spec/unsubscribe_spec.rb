require 'spec_helper'

describe Sendcloud::Unsubscribe do
  before :each do
    @sendcloud = Sendcloud({
      #:api_key  => 'api-key'
      :api_user => 'postmaster@categorya.sendcloud.org',
      :api_key  => 'api-key'
    })
    @sampe = {
      :email => 'test@gmail.com'
    }
  end
  
  describe "find unsubscribes list" do
    it "should make a GET request with the right params" do
      unsubscribe_url = @sendcloud.unsubscribes.send(:unsubscribe_url, "get")
      sampe_response = <<EOF
      {
        "message": "success", 
        "unsubscribes": [
          "unsubscribe": {"email": "#{@sampe[:email]}", "created_at": "2013-03-27 17:34:46"},
          "unsubscribe": {"email": "test2@gmail.com", "created_at": "2013-03-28 17:34:46"}
        ]
      }
EOF
      Sendcloud.should_receive(:submit).with(:get, unsubscribe_url, {}).and_return(sampe_response)
      @sendcloud.unsubscribes.list
    end
  end
  
  describe "add unsubscribe" do
    it "should make a POST request with correct params to add a given email address" do
      unsubscribe_url = @sendcloud.unsubscribes.send(:unsubscribe_url, "add")
      sampe_response = <<EOF
      {
        "message": "success", 
        "unsubscribe": {"email": "#{@sampe[:email]}", "created_at": "2013-03-27 17:34:46"}
      }
EOF
      Sendcloud.should_receive(:submit).with(:post, unsubscribe_url, {:email => @sampe[:email]}).and_return(sampe_response)
      @sendcloud.unsubscribes.add(@sampe[:email]) 
    end
  end
  
  describe "remove unsubscribe" do
    it "should make a DELETE request with right params to remove a given email address" do
      unsubscribe_url = @sendcloud.unsubscribes.send(:unsubscribe_url, "delete")
      sampe_response = <<EOF
      {
        "message": "success", 
        "del_count": 1
      }
EOF
      Sendcloud.should_receive(:submit).with(:post, unsubscribe_url, {:email => @sampe[:email]}).and_return(sampe_response)
      @sendcloud.unsubscribes.remove({:email => @sampe[:email]})
    end
  end
end