require_relative 'data_mapper_setup'

ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require 'database_cleaner'

require './app/models/bookmark.rb'
require './app/models/tag.rb'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  register Sinatra::Flash

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
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    # we just initialize the object
    # without saving it. It may be invalid
    @user = User.new(email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])
    if @user.save # #save returns true/false depending on whether the model is successfully saved to the database.
      session[:user_id] = @user.id
      redirect to('/links')
      # if it's not valid,
      # we'll render the sign up form again
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  run! if app_file == $0

end
