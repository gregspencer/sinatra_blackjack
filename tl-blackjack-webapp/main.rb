require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?

set :sessions, true

get '/' do
	if session[:player_name]
		erb :game
	else
  		erb :set_name
  	end
end

post '/set_name' do
	session[:player_name] = params[:player_name]
	redirect to '/game'
end

get '/game' do
	session[:deck] = ['2', '3', '4',  '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].product(['Diamonds', 'Spades', 'Hearts', 'Clubs']).shuffle!
	session[:player_cards] =[]
	session[:player_cards] << session[:deck].pop
	session[:player_cards] << session[:deck].pop

	session[:dealer_cards] =[]
	session[:dealer_cards] << session[:deck].pop
	session[:dealer_cards] << session[:deck].pop
	erb :game
end

get '/nested_template' do
	erb :"users/profile"
end



