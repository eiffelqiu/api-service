module Note
  class Msgs < Grape::API
    prefix "api"
    version 'v1', :using => :path
    format :json
    
    resource 'msgs' do
      get "/" do
       ::Msg.all.to_json(except: [:id, :created_at, :updated_at, :uuid, :sns, :ip, :app, :model])
     end
      
      get "/:id" do 
        ::Msg.find(params[:id])
      end
      
      post "/create" do
        @msg = ::Msg.new
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
