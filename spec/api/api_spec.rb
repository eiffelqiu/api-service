require_relative '../spec_helper.rb'

describe "Note::Msgs" do

  include Rack::Test::Methods

  def app
    ::Note::Msgs
  end	

  describe "GET /api/v1/msgs" do

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
  
end