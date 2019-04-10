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
        flash[:error] = "You must be logged in to view."
        redirect to '/login'
      end
    end

    post '/exercises/new' do
      if logged_in?
        @today = Date.today
        @exercise = Exercise.create(name: params[:name], minutes: params[:minutes], date: params[:date])
        binding.pry
        if @exercise.valid? && @exercise.date <= @today
          @current_user = User.find_by_id(session[:user_id])
          @exercise.user_id = @current_user.id
          @exercise.save
          redirect to "/exercises/#{@exercise.id}"
        else
          flash[:error] = "Please try again."
          redirect to '/exercises/new'
        end
      end
    end

# View one exercise record
  get '/exercises/:id' do
    if logged_in?
      @current_user = User.find_by_id(session[:user_id])
      @exercise = Exercise.find_by_id(params[:id])
      if @exercise.user_id == @current_user.id
        erb :'/exercises/show'
      else
        flash[:error] = "You can only view your exercise records."
        redirect to "/users/#{@current_user.username}"
      end
    else
      flash[:error] = "You must be logged in to view."
      redirect to '/login'
    end
  end

  get '/exercises/:id/edit' do
    if logged_in?
      @exercise = Exercise.find_by_id(params[:id])
      @current_user = User.find_by_id(session[:user_id])
      if @exercise.user_id == @current_user.id
        erb :'/exercises/edit'
      else
        flash[:error] = "You cannot edit other people's records."
        redirect to "/users/#{@current_user.username}"
      end
    else
      flash[:error] = "You must be logged in to view."
      redirect to '/login'
    end
  end

# Edit one exercise record
  patch '/exercises/:id' do
    @exercise = Exercise.find_by_id(params[:id])
    if params[:exercise][:name] != ""
      @exercise.name = params[:exercise][:name]
    end
    if params[:exercise][:date] != ""
      @exercise.date = params[:exercise][:date]
    end
    if params[:exercise][:minutes] != ""
      @exercise.minutes = params[:exercise][:minutes]
    end
    @exercise.save
    redirect to "/exercises/#{@exercise.id}"
  end

# Delete one exercise record
  delete '/exercises/:id' do
    if logged_in?
      @exercise = Exercise.find_by_id(params[:id])
      @current_user = User.find_by_id(session[:user_id])
      if @exercise.user_id == @current_user.id
        @exercise.delete
        redirect to "/users/#{@current_user.username}"
      else
        redirect to '/exercise'
      end
    else
      redirect to '/login'
    end
  end

end
