class GamesController < ApplicationController
    get '/games' do
        @games = Game.all
        erb :'games/index'
    end

    get '/mygames' do
        @games = Game.where(user_id: session[:user_id])
        # suggested: @games = current_user.games
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
        #@game = current_user.games.create
        redirect "/games/#{@game.id}/play"
    end

    # Create        | Read          | Update            | Delete
    # post /games   | get /games    | patch /games/:id  | delete /games/:id
    # redirect      | index.erb     | redirect          | redirect

                   #| get /games/:id |
                   #| show.erb

                   #| get /games/new |
                   #| new.erb

                   #| get /games/edit |
                   #| edit.erb


    get '/games/:id' do
        @game = Game.find_by(id: params[:id])
        erb :'games/show'
    end

    get '/games/:id/play' do
        @game = Game.find_by(id: params[:id])
        erb :'games/play'
    end

    patch '/games/:id/play' do #should remove play
        @game = Game.find_by(user_id: session[:user_id], id: params[:id])
        if !@game
           redirect '/games' 
        else
            @game.update(game_length: params[:game_length], won: params[:won] )
            redirect "/games"
        end
    end

    delete '/games/:id' do
        @game = Game.find_by(user_id: session[:user_id], id: params[:id])
        if @game
            @game.delete
            redirect "/mygames"
        else
            erb :"games/invalid_delete"
        end
    end
 
end
