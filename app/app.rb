ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/models/bookmark.rb'
require 'database_cleaner'

# ENV['RACK_ENV'] ||= 'development'
p ENV['RACK_ENV']

class BookmarkManager < Sinatra::Base

  get '/' do
    "Hello"
  end

  get '/links' do
    @links = Bookmark.all
    erb :links
  end

  get '/links/new' do
    erb :new
  end

  post '/links' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/links'
  end

  run! if app_file == $0

end
