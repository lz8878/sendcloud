require 'spec_helper'

describe Sendcloud::Bounce do
  before :each do
    @sendcloud = Sendcloud({
      #:api_key  => 'api-key'
      :api_user => 'postmaster@categorya.sendcloud.org',
      :api_key  => 'api-key'
    })
    
    @sampe = {
      :email => "test@test.sendcloud.org"
    }
  end
  
  describe "bounce list" do
    it "should make a GET request with right params to find bounces" do
       bounce_url = @sendcloud.bounces.send(:bounce_url)
       sampe_response = <<EOF
       {
         "message": "success",
         "bounces": [
           "bounce": {
             "email": "636668452@qq.com",
             "reason": "Mailboxnotfound.http://service.mail.qq.com/cgi-bin/help?subtype=1&amp;&amp;id=20022&amp;&amp;no=1000728",
             "create_at": "2013-04-10 16:45:03"
           },
           "bounce": {
             "email": "4668374827@qq.com",
             "reason": "Mailboxnotfound.http://service.mail.qq.com/cgi-bin/help?subtype=1&amp;&amp;id=20022&amp;&amp;no=1000728",
             "create_at": "2013-04-10 16:44:48"
           }
         ]
       }
EOF
       Sendcloud.should_receive(:submit).with(:get, bounce_url, {}).and_return(sampe_response);
       @sendcloud.bounces.list
    end
  end
  
  describe "bounces count" do
    it "should make a GET request with correct params to count bounces" do
      bounce_url = @sendcloud.bounces.send(:bounce_url, "count")
      sampe_response = '{ "message": "success", count: 1 }';
      Sendcloud.should_receive(:submit).with(:get, bounce_url, {:days => 2}).and_return(sampe_response);
      @sendcloud.bounces.count({:days=>2})
    end
  end

  describe "add bounce" do
    it "should make a POST request with correct params to add a given email addres" do
      bounce_url = @sendcloud.bounces.send(:bounce_url, "add")
      sampe_response = '{ "message": "success", add_count: 1 }';
      Sendcloud.should_receive(:submit).with(:post, bounce_url, {:email => @sampe[:email]}).and_return(sampe_response);
      @sendcloud.bounces.add @sampe[:email]
    end
  end
  
  describe "delete bounce" do
    it "should make a POST request with right params to add a given email addres" do
      bounce_url = @sendcloud.bounces.send(:bounce_url, "delete")
      sampe_response = '{ "message": "success", del_count: 1 }';
      Sendcloud.should_receive(:submit).with(:post, bounce_url, {:email => @sampe[:email]}).and_return(sampe_response);
      @sendcloud.bounces.delete({:email => @sampe[:email]})
    end
  end
end