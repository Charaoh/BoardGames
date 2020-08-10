require './config/environment'

class UsersController < ApplicationController 

  get '/users/login' do
    erb :"users/login"
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password])
        session[:users_id] = @user.id
        redirect "/users/:id"
      else
        erb :"users/invalid_login"
      end
  end
 
  get '/users/new' do
    erb :"users/new" 
  end

  post '/users' do
    @user = User.create(params)
      if @user != nil
        session[:users_id] = @user.id
        redirect "/games"
      else
        erb :"users/invalid_new"
      end
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :"users/home"

    # @total_games_won = self.games.where(user_id: self.id).size
    # @total_games_played = self.games.size
    # @total_games_lost = total_games_played - total_games_won
    
  end

  get '/' do
    erb :main
  end
  
  get '/logout' do
    logout!
  end  

end
