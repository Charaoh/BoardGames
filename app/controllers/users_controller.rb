class UsersController < ApplicationController 
  get '/users/login' do
    erb :"users/login"
  end

  post '/users/login' do
    @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password]) 
        session[:user_id] = @user.id
        redirect "/users/home"
      else
        erb :"users/invalid_login"
      end
  end
 
  get '/users/new' do
    erb :"users/new" 
  end

  post '/users' do
    @user = User.new(params)
      if @user.save  
        session[:user_id] = @user.id
        redirect "/users/home"
      else
        erb :"users/invalid_new"
      end
  end

  get '/users/home' do
    verify
    erb :"users/home"
  end

  get '/users/edit' do
    verify
    erb :"users/edit"    
  end

  patch '/users' do
    verify
    current_user.email = params[:email]
    current_user.name = params[:name]
    if params[:password] != ""
      current_user.password = params[:password]
    end
    if current_user.save
      redirect "/users/home"
    else
      erb :"users/edit"
    end
  end

  delete '/users' do
    verify
    current_user.destroy 
    logout!
    redirect '/'
  end

  get '/' do
    erb :main
  end
  
  get '/logout' do
    logout!
  end  

end
