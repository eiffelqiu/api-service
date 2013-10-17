require 'pp'

module Note
  class Messages < Grape::API
    prefix "api"
    version 'v1', :using => :path
    format :json
    
    resource 'messages' do
      get "/" do
        ::Message.all
      end
      
      get "/:id" do 
        ::Message.find(params[:id])
      end
      
      post "/create" do
        @msg = ::Message.new
        @msg.name = params[:name] || 'anonymous'
        @msg.body = params[:body] || ''
        @msg.email = params[:email] || 'anonymous@likenote.com'
        @msg.sns = params[:sns] || ''
        @msg.uuid = params[:uuid] || ''
        @msg.model = params[:model] || 0
        @msg.app = params[:app] || ''
        @msg.ip = params[:ip] || ''
        @msg.save!
      end
    end
  end
end