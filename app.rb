require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/item.rb'

get '/' do
    @items = Item.all
    @total = Item.sum(:price)
    erb :index
end

post '/create' do
    Item.create({
        title: params[:title],
        price: params[:price]
    })
    redirect '/'
end

post '/delete/:id' do
    Item.find(params[:id]).destroy
    redirect '/'
end

post '/edit/:id' do
    @item = Item.find(params[:id])
    erb :edit
end

post '/renew/:id' do
    @item = Item.find(params[:id])
    @item.update({
        title: params[:title],
        price: params[:price]
    })
    redirect '/'
end