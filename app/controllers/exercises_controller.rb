class ExercisesController < ApplicationController

# See all the exercises of all users for today
  get '/exercises' do
    redirect_unless_logged_in
    erb :'/exercises/index'
  end

# User can create a new exercise record
  get '/exercises/new' do
    redirect_unless_logged_in
    erb :'/exercises/new'
  end

  post '/exercises' do
    redirect_unless_logged_in
    if params[:date].to_date <= Date.today && Exercise.new(params).valid?
      @exercise = Exercise.create(name: params[:name], minutes: params[:minutes], date: params[:date])
      @exercise.user_id = current_user.id
      @exercise.save
      redirect to "/exercises/#{@exercise.id}"
    end
  end

# View one exercise record
  get '/exercises/:id' do
    redirect_unless_logged_in
    @exercise = Exercise.find_by_id(params[:id])
    if @exercise.user_id == current_user.id
      erb :'/exercises/show'
    else
      flash[:error] = "You cannot view other people's records."
      redirect to "/users/#{current_user.username}"
    end
  end

  get '/exercises/:id/edit' do
    redirect_unless_logged_in
    @exercise = Exercise.find_by_id(params[:id])
    if @exercise.user_id == current_user.id
      erb :'/exercises/edit'
    else
      flash[:error] = "You cannot edit other people's records."
      redirect to "/users/#{current_user.username}"
    end
  end

# Edit one exercise record
  patch '/exercises/:id' do
    @exercise = Exercise.find_by_id(params[:id])
    if params[:exercise] != ""
      @exercise.update(params[:exercise])
    end
    redirect to "/exercises/#{@exercise.id}"
  end

# Delete one exercise record
  delete '/exercises/:id' do
    redirect_unless_logged_in
    @exercise = Exercise.find_by_id(params[:id])
    if @exercise.user_id == current_user.id
      @exercise.delete
    else
      flash[:error] = "You cannot delete other people's records."
    end
    redirect to "/users/#{current_user.username}"
  end

end
