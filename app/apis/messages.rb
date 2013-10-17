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
        ::Message.create(params[:message])
      end
    end
  end
end