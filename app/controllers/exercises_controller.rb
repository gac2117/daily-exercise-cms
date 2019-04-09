class ExercisesController < ApplicationController

# See all the exercises of all users for today
  get '/exercises' do
    if logged_in?
      @exercises = Exercise.all
      @today = Date.today
      erb :'/exercises/index'
    else
      redirect to '/login'
    end
  end

# User can create a new exercise record
  get '/exercises/new' do
      if logged_in?
        erb :'/exercises/new'
      else
        redirect to '/login'
      end
    end

    post '/exercises/new' do
      if logged_in?
        if params[:name] == "" || params[:minutes] == "" || params[:date] == ""
          redirect to '/exercises/new'
        else
          @exercise = Exercise.create(name: params[:name], minutes: params[:minutes], date: params[:date])
          @current_user = User.find_by_id(session[:user_id])
          @exercise.user_id = @current_user.id
          @exercise.save
          redirect to "/users/#{@current_user.username}"
        end
      end
    end

# View one exercise record
  get '/exercises/:id' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @exercise = Exercise.find_by_id(params[:id])
      erb :'/exercises/show'
    else
      redirect to '/login'
    end
  end

  get '/exercises/:id/edit' do
    if logged_in?
      @exercise = Exercise.find_by_id(params[:id])
      erb :'/exercises/edit'
    else
      redirect to '/login'
    end
  end

# Edit one exercise record
  patch '/exercises/:id' do
    @exercise = Exercise.find_by_id(params[:id])
    @exericse.name = params[:name]
    @exericse.date = params[:date]
    @exericse.minutes = params[:minutes]
    @exericse.save
  end
  
# Delete one exercise record
  delete '/exercises/:id' do
    if logged_in?
      @exercise = Exercise.find_by_id(params[:id])
      @current_user = User.find_by_id(session[:user_id])
      if @exercise.user_id == @current_user.id
        @exercise.delete
      else
        redirect to '/exercise'
      end
    end
  end

end
