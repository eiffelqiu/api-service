require 'goliath/test_helper'
require 'em-synchrony/activerecord'
require 'grape'
require 'goliath'

require File.dirname(__FILE__) + '/../app/api/msgs'
require File.dirname(__FILE__) + '/../app/models/msg'
require File.dirname(__FILE__) + '/../config/application'

# 初始化时加载路径 app/api app/lib app/models
%w[api models lib].each do |folder|
   $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../app/#{folder}"))
end

Goliath.env = :test

RSpec.configure do |c|
  c.include Goliath::TestHelper, :example_group => {
    :file_path => /spec\//
  }
end

require 'rack/test'

describe "Note::Msgs" do
  include Rack::Test::Methods

  def app
    ::Note::Msgs
  end	

  describe "GET /api/v1/msgs" do

    it "return hello string" do
      get "/api/v1/msgs/hello"
      last_response.status.should == 200
    end

    it "return an array of messages" do
      get "/api/v1/msgs"
      last_response.status.should == 200
    end

  end
end