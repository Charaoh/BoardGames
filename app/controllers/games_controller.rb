require './config/environment'

class GamesController < ApplicationController

    get '/games' do
        @games = Game.all
        erb :'games/index'
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
        erb :'games/show'
    end

    post '/games/:id/show' do
        @game = Game.find_by(id: params[:id])
        if !Game.find_by(user_id: params[:user_id], id: params[:id])
            Game.create(user_id: params[:user_id], id: params[:id])
        else
            redirect "/games/#{@game.id}"
        end
    end

    get '/games/:id/play' do
        @game = Game.find_by(id: params[:id])
        erb :'games/play'
    end

    post '/games/:id/play' do
        @game = Game.find_by(id: params[:id])
        if !Game.find_by(user_id: params[:user_id], id: params[:id])
           redirect 'games/index' 
        end
    end
 
end
