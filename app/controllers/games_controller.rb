class GamesController < ApplicationController
    get '/games' do
        @games = Game.all
        erb :'games/index'
    end

    get '/mygames' do
        @games = Game.where(user_id: session[:user_id])
        erb :'games/user_index'
    end

    post '/games/user_index' do
        @games = Game.find_by(user_id: params[:user_id])
        
    end

    get '/games/new' do
        erb :'games/new'
    end

    post '/games' do
        @game = Game.create(user_id: session[:user_id])
        redirect "/games/#{@game.id}/play"
    end

    get '/games/:id' do
        @game = Game.find_by(id: params[:id])
        erb :'games/show'
    end

    get '/games/:id/play' do
        @game = Game.find_by(id: params[:id])
        erb :'games/play'
    end

    patch '/games/:id/play' do
        @game = Game.find_by(user_id: session[:user_id], id: params[:id])
        if !@game
           redirect '/games' 
        else
            @game.update(game_length: params[:game_length], won: params[:won] )
            redirect "/games"
        end
    end

    get '/games/:id/delete' do
        @game = Game.find_by(id: params[:id])
        erb :'games/delete'        
    end

    post '/games/:id/delete' do
        if !Game.find_by(user_id: params[:user_id], id: params[:id])
            Game.drop(user_id: params[:user_id], id: params[:id])
        else
            erb :"games/invalid_delete"
        end
    end
 
end
