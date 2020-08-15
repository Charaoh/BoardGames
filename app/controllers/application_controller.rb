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
      !!session[:user_id]
    end

    def logout!
      session.clear
      redirect '/' 
    end

    def current_user
      @user ||= User.find_by(id: session[:user_id])
    end

    def verify
      if !logged_in?
        redirect "/users/login"
      end
    end

  end
end
