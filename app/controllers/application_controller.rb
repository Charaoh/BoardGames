class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "playmyboardgame"
  end

  get '/' do
    erb :main
  end 

  helpers do
    
    def logged_in?
      !!session[:username]
    end

    def logout!
      session.clear
      redirect '/' 
    end

  end

end
