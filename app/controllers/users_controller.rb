class UsersController < ApplicationController

# User signs up for a new account
  get '/signup' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      redirect to "/users/#{@user.username}"
    else
      erb :'/users/new'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
   if @user.valid?
     session[:user_id] = @user.id
     redirect to '/exercises/new'
   else
     redirect to '/signup'
   end
 end

# User logs into account
 get '/login' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      redirect to "/users/#{@user.username}"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/users/#{@user.username}"
    else
      redirect to '/login'
    end
  end

# User logs out of session
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

# User can see all exercise records for self
  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    @current_user = User.find_by_id(session[:user_id])
    if @user.username == @current_user.username
      erb :'/users/show'
    else
      redirect to "/users/#{@current_user.username}"
    end
  end

end
