ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/models/bookmark.rb'
require './app/models/tag.rb'
require 'database_cleaner'

require_relative 'data_mapper_setup'

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
    p bookmark = Bookmark.create(url: params[:url], title: params[:title])
    p params[:tags]
    p tag = Tag.first_or_create(name: params[:tags])
    p bookmark.tags << tag
    p bookmark.save
    redirect '/links'
  end

  run! if app_file == $0

end
