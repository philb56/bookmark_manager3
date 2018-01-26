class BookmarkManager < Sinatra::Base

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

end
