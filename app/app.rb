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
    bookmark = Bookmark.create(url: params[:url], title: params[:title])
    tag = Tag.new(name: params[:tags])
    bookmark.tags << tag
    bookmark.save
    # bookmark = Bookmark.create(url: params[:url], title: params[:title], tags: [Tag.new(name: params[:tags])])
    redirect '/links'
  end

  get '/tags/:name' do
   tag = Tag.first(name: params[:name])
   @links = tag ? tag.bookmarks : []
   erb :'/links'
  end


  run! if app_file == $0

end
