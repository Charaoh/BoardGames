class GamesController < ApplicationController
    get '/games' do
        verify
        @games = Game.all
        erb :'games/index'
    end

    get '/mygames' do
    
        verify
        @games = Game.where(user_id: session[:user_id])
        erb :'games/user_index'
    end

    # post '/games/user_index' do
    #     @games = Game.find_by(user_id: params[:user_id])
    # end

    get '/games/new' do
        verify
        erb :'games/new'
    end

    post '/games' do
        @game = Game.create(user_id: session[:user_id])
        redirect "/games/#{@game.id}/play"
    end

    get '/games/:id' do
        @game = Game.find_by(id: params[:id])
        if @game == nil
             erb :'games/invalid_delete'
        else
            erb :'games/show'
        end
    end

    get '/games/:id/play' do
        @game = Game.find_by(id: params[:id])
        if @game.user != current_user
            redirect '/games'
        else
            erb :'games/play'
        end
    end

    get '/games/:id/play_again' do
        @game = Game.find_by(id: params[:id])
        if @game.user != current_user
            redirect '/games'
        else
            erb :'games/play_again'
        end
    end

    patch '/games/:id' do
        @game = Game.find_by(id: params[:id])
        if @game.user != current_user
           redirect '/games' 
        else
            @game.update(game_length: params[:game_length], won: params[:won] )
            redirect "/mygames"
        end
    end

    # get '/games/:id/delete' do
    #     @game = Game.find_by(id: params[:id])
    #     erb :'games/delete'        
    # end

    delete '/games/:id' do
        @game = Game.find_by(id: params[:id])
        if @game.user == current_user
            @game.delete
            redirect "/mygames"
        else
            erb :"games/invalid_delete"
        end
    end
end
