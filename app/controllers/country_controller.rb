class CountryController < ApplicationController

  get '/countries' do
    if logged_in? && current_user
      @traveler = current_user#if the current user is logged in show user's countries list.
      session[:traveler_id] = @traveler.id
      @countries = Country.all
      erb :'/countries/index'
    else
      redirect '/'#if the current user is not logged in, redirect to root.
    end
  end

  get '/countries/new' do
    @country = Country.find_by(id: params[:id])
    @countires = Country.all
    if logged_in? && current_user
      @traveler = current_user
      session[:traveler_id] = @traveler.id
      erb :'countries/new'#page to add new countries to list, if current user is logged in.
    else
      redirect '/'
    end
  end

  post '/countries' do
    @traveler = current_user
    if logged_in?
    @country = Country.create(name: params[:name])
    @traveler.countries << @country
      redirect '/countries'#inserts new country into traveler's country list and returns to index.
    else
      redirect '/countries/new'
    end
  end

  get '/countries/:id' do
    if logged_in?
      @traveler = current_user
      @country = Country.find_by(id: params[:id])
      erb :'countries/show'
    else
      redirect '/'
    end
  end

  get '/countries/:id/edit' do
    if logged_in?
    @countries = Country.find_by(id: params[:id])
      erb :'countries/edit'
    else
      redirect '/'
    end
  end

  patch '/countries/:id' do
    if logged_in? && !params[:name].empty?
      @country = Country.find_by_id(params[:id])
      @country.update(name: params[:name])
      @country.save
      redirect "/countries/#{@country.id}"
    else
      redirect "/countries/#{@country.id}/edit"
    end
  end

  delete '/countries/:id/delete' do
    @country = Country.find_by_id(params[:id])
    @traveler = current_user
    if logged_in?
      @country.delete
      redirect '/countries'
    else
      redirect "/countries/#{@country.id}"
    end
  end
end
