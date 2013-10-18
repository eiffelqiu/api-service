require_relative '../spec_helper.rb'

class Test < Goliath::API
  def response(env)
    ::Note::Msgs.call(env)
  end
end

Goliath.run_app_on_exit = false

describe ::Note::Msgs do

  include Rack::Test::Methods
  include Goliath::TestHelper

  let(:err) { Proc.new { |c| fail "HTTP Request failed #{c.response}" } }

  it "return an array of messages" do
    with_api(Test) do
      get_request({:path => "/api/v1/msgs" }, err) do |c|
        c.response_header.status.should == 200
      end
    end
  end  

  it "return hello string" do
    with_api(Test) do
      get_request({:path => "/api/v1/msgs/hello" }, err) do |c|
        c.response_header.status.should == 200
        c.response.should == '"hello"'
      end
    end
  end

end