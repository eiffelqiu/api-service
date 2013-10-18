require_relative '../spec_helper.rb'

def app
  ::Note::Msgs
end   

Goliath.run_app_on_exit = false

describe ::Note::Msgs do

  include Rack::Test::Methods
  include Goliath::TestHelper

  it "return hello string" do
    get "/api/v1/msgs/hello"
    last_response.status.should == 200
    last_response.body.should == '"hello"'
  end

  it "return an array of messages" do
    get "/api/v1/msgs"
    last_response.status.should == 200  
  end

end