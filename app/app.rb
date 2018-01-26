require_relative 'data_mapper_setup'

ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/models/bookmark.rb'
require './app/models/tag.rb'
require 'database_cleaner'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

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
    bookmark = Bookmark.first_or_create(url: params[:url], title: params[:title])
    params[:tags].split.each do |tag|
      bookmark.tags << Tag.first_or_create(name: tag)
    end
    bookmark.save
    redirect '/links'
  end

  get '/tags/:name' do
   tag = Tag.first(name: params[:name])
   @links = tag ? tag.bookmarks : []
   erb :'/links'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
                       password: params[:password])
    #session[:user_id] = user.id
    redirect to('/links')
  end

  run! if app_file == $0

end
