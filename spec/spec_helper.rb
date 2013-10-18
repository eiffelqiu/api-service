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