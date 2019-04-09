class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect to '/exercises'
    else
      erb :'/users/new'
    end
  end

  post '/signup' do
   if params[:username] == "" || params[:email] == "" || params[:password] == ""
     redirect to '/signup'
   else
     @user = User.create(username: params[:username], email: params[:email], password: params[:password])
     session[:user_id] = @user.id
     redirect to '/exercises'
   end
 end

end
