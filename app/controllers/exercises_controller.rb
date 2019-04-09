class ExercisesController < ApplicationController

# See all the exercises of all users for today
  get '/exercises' do
    @exercises = Exercise.all
    if logged_in?
      erb :'/exercises/index'
    else
      redirect to '/login'
    end
  end
# User can create a new record of exercise
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
        end
      end
    end
# View one exercise record
  get '/exercises/:id' do
    if logged_in?
      @exercise = Exercise.find_by_id(params[:id])
      erb :'exercises/show'
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

  patch '/exercises/:id' do
    @exercise = Exercise.find_by_id(params[:id])
    @exericse.name = params[:name]
    @exericse.date = params[:date]
    @exericse.minutes = params[:minutes]
    @exericse.save
  end
end
