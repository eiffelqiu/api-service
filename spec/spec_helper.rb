require 'em-synchrony/activerecord'
require 'rack/test'
require 'grape'
require 'goliath'
require 'goliath/test_helper'

Goliath.env = :test
ENV["RACK_ENV"] ||= 'test'

require_relative '../app/api/msgs'
require_relative '../app/models/msg'
require_relative '../config/application'

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.include Goliath::TestHelper, :example_group => {
    :file_path => /spec\//
  }  
end

# 自定义Log的输出样式
Goliath::Request.log_block = proc do |env, response, elapsed_time|
  method = env[Goliath::Request::REQUEST_METHOD]
  path = env[Goliath::Request::REQUEST_URI]

  env[Goliath::Request::RACK_LOGGER].info("#{response.status} #{method} #{path} in #{'%.2f' % elapsed_time} ms")
end
