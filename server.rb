require "rubygems"
require "bundler/setup"
require 'goliath'
require 'em-synchrony/activerecord'
require 'grape'
require File.dirname(__FILE__) + '/app/api/msgs'
require File.dirname(__FILE__) + '/app/models/msg'

# 初始化时加载路径 app/api app/lib app/models
%w[api models lib].each do |folder|
   $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/app/#{folder}"))
end

# 自定义Log的输出样式
Goliath::Request.log_block = proc do |env, response, elapsed_time|
  method = env[Goliath::Request::REQUEST_METHOD]
  path = env[Goliath::Request::REQUEST_URI]

  env[Goliath::Request::RACK_LOGGER].info("#{response.status} #{method} #{path} in #{'%.2f' % elapsed_time} ms")
end

class Application < Goliath::API

  def response(env)
    ::Note::Msgs.call(env)
  end

end