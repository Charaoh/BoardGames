require './config/environment'

class GamesController < ApplicationController

    get '/games' do
        @games = Game.all
        erb :'games/index'
    end

    get '/games/user_index' do
        @games = Game.find_by(user_id: params[:user_id])
        erb :'games/user_index'
    end

    post '/games/user_index' do
        @games = Game.find_by(user_id: params[:user_id])
        
    end

    get '/games/new' do
        erb :'games/new'
    end

    post '/games' do
        @game = Game.create(user_id: params[:user_id], id: params[:id])
        redirect "/games/#{@game.id}"
    end

    get '/games/:id' do
        @game = Game.find_by(id: params[:id])
        erb :'games/play'
    end

    post '/games/:id/play' do
        if !Game.find_by(user_id: params[:user_id], id: params[:id])
           redirect 'games/index' 
        elsif Game.find_by(user_id: params[:user_id], id: params[:id])
            redirect "/games/#{@game.id}"
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
