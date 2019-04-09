class ExercisesController < ApplicationController

  get '/exercises' do
    @exercises = Exercise.all
    if logged_in?
      erb :'/exercises/index'
    else
      redirect to '/login'
    end
  end

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

end
