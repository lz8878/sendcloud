require 'spec_helper'

describe Sendcloud::Stats do
  before :each do
    @sendcloud = Sendcloud({
      #:api_key  => 'api-key'
      :api_user => 'postmaster@categorya.sendcloud.org',
      :api_key  => 'api-key'
    })
  end
  
  describe "category list" do
    it "should make a GET request to find category list" do
      sample_response = '{"message":"success","categories":[{"category":"postmaster@categorya.sendcloud.org"}]}';
      stats_url = @sendcloud.stats.send(:stats_url)
      Sendcloud.should_receive(:submit).with(:get, stats_url, {:list => true}).and_return(sample_response)
      @sendcloud.stats.get_categories
    end
  end
  
  describe "find stats" do
    describe "find by dates" do
      let(:sample_response) do
        sample_response = <<EOF
        {
            "message": "success",
            "stats": [
                      {
                       "sendDate": "2012-07-26",
                       "category": 18,
                       "deliveredNum": 72,
                       "clickNum": 8,
                       "openNum": 21,
                       "bounceNum": 0,
                       "spamReportedNum": 0,
                       "unsubscribeNum": 0,
                       "uniqueOpensNum": 21,
                       "repeatBouncesNum": 0,
                       "invalidEmailsNum": 2,
                       "repeatSpamReports": 0,
                       "spamAppDrops": 8,
                       "request": 72,
                       "delivered_percent": 100,
                       "click_percent": 11,
                       "open_percent": 29,
                       "bounce_percent": 0,
                       "spamReported_percent": 0,
                       "unsubscribe_percent": 0,
                       "uniqueOpens_percent": 29,
                       "uniqueClicks_percent": 5,
                       "repeatBounces_percent": 0,
                       "invalidEmails_percent": 2,
                      "repeatSpamReports_percent": 0
                    },
                  {
                      "sendDate": "2012-07-25",
                      "category": "postmaster@categorya.sendcloud.org",
                      "deliveredNum": 506,
                      "clickNum": 52,
                      "openNum": 118,
                      "bounceNum": 0,
                      "spamReportedNum": 0,
                      "unsubscribeNum": 1,
                      "uniqueOpensNum": 114,
                      "repeatBouncesNum": 0,
                      "invalidEmailsNum": 106,
                      "repeatSpamReports": 0,
                      "spamAppDrops": 279,
                      "request": 506,
                      "delivered_percent": 100,
                      "click_percent": 10,
                      "open_percent": 23,
                      "bounce_percent": 0,
                      "spamReported_percent": 0,
                      "unsubscribe_percent": 0,
                      "uniqueOpens_percent": 22,
                      "uniqueClicks_percent": 8,
                      "repeatBounces_percent": 0,
                      "invalidEmails_percent": 20,
                      "repeatSpamReports_percent": 0
                    }
            ]
      }
EOF
      end
      
      it "should make a GET request to find stats by days" do
        stats_url = @sendcloud.stats.send(:stats_url)
        Sendcloud.should_receive(:submit).with(:get, stats_url, {:days => 2}).and_return(sample_response)
        @sendcloud.stats.get({:days => 2})
      end
      
      it "should make a GET request to find stats between start_date and end_date" do
        stats_url = @sendcloud.stats.send(:stats_url)
        Sendcloud.should_receive(:submit).with(:get, stats_url, {:start_date => '2012-07-25', :end_date => '2012-07-26'}).and_return(sample_response)
        @sendcloud.stats.get({:start_date => '2012-07-25', :end_date => '2012-07-26'})
      end
    end
    
    it "should make a GET request to find stats by category[]" do
      sample_response = <<EOF
      {
        "message": "success",
        "stats": [
            {
                 "category": "postmaster@categorya.sendcloud.org",
                 "deliveredNum": 8213,
                 "clickNum": 893,
                 "openNum": 893,
                 "bounceNum": 0,
                 "spamReportedNum": 0,
                 "unsubscribeNum": 12,
                 "uniqueOpensNum": 4120,
                 "repeatBouncesNum": 0,
                 "invalidEmailsNum": 1098,
                 "repeatSpamReports": 0,
                 "spamAppDrops": 2170,
                 "request": 8213,
                 "delivered_percent": 100,
                 "click_percent": 10.873006,
                 "open_percent": 26.579813,
                 "bounce_percent": 0,
                 "spamReported_percent": 0,
                 "unsubscribe_percent": 0.14610982,
                 "uniqueOpens_percent": 50.164375,
                 "uniqueClicks_percent": 8.876172,
                 "repeatBounces_percent": 0,
                 "invalidEmails_percent": 13.369049,
                 "repeatSpamReports_percent": 0,
                 "spamAppDrops_percent": 0
            },
            {
                 "category": "postmaster@categoryb.sendcloud.org",
                 "deliveredNum": 8213,
                 "clickNum": 893,
                 "openNum": 893,
                 "bounceNum": 0,
                 "spamReportedNum": 0,
                 "unsubscribeNum": 12,
                 "uniqueOpensNum": 4120,
                 "repeatBouncesNum": 0,
                 "invalidEmailsNum": 1098,
                 "repeatSpamReports": 0,
                 "spamAppDrops": 2170,
                 "request": 8213,
                 "delivered_percent": 100,
                 "click_percent": 10.873006,
                 "open_percent": 26.579813,
                 "bounce_percent": 0,
                 "spamReported_percent": 0,
                 "unsubscribe_percent": 0.14610982,
                 "uniqueOpens_percent": 50.164375,
                 "uniqueClicks_percent": 8.876172,
                 "repeatBounces_percent": 0,
                 "invalidEmails_percent": 13.369049,
                 "repeatSpamReports_percent": 0,
                 "spamAppDrops_percent": 0
            }
        ]
    }
EOF
      stats_url = @sendcloud.stats.send(:stats_url)
      Sendcloud.should_receive(:submit).with(:get, stats_url, {:category => ['postmaster@categorya.sendcloud.org', 'postmaster@categoryb.sendcloud.org']}).and_return(sample_response)
      @sendcloud.stats.get({:category => ['postmaster@categorya.sendcloud.org', 'postmaster@categoryb.sendcloud.org']})
    end
    
  end
end