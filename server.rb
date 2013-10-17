require "rubygems"
require "bundler/setup"
require 'goliath'
require 'em-synchrony/activerecord'
require 'grape'
require './app/apis/messages'
require './app/models/message'

class Application < Goliath::API

  def response(env)
    ::Note::Messages.call(env)
  end

end