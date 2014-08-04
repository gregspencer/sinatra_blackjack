require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?

set :sessions, true

helpers do
	def calculate_total(cards)
		arr = cards.map{|element| element[0]}
		total = 0
		arr.each do |a|
			if a == "Ace"
				total += 11
			else
				total += a.to_i == 0 ? 10 : a.to_i
			end
	end
	arr.select{|element| element == "Ace"}.count.times do
		break if total <= 21
		total -= 10
		end
	end
end
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



