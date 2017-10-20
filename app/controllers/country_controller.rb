class CountryController < ApplicationController

  get '/countries' do
    if logged_in? && current_user
      @traveler = current_user
      session[:traveler_id] = @traveler.id
      @countries = Country.all
      erb :'/countries/index'
    else
      redirect '/'
    end
  end

  get '/countries/new' do
    @country = Country.find_by(id: params[:id])
    if logged_in? && current_user
      @traveler = current_user
      session[:traveler_id] = @traveler.id
      erb :'countries/new'
    else
      redirect '/'
    end
  end

  post '/countries' do
    @country = current_user
    if logged_in? && !params[:name].empty?
    @country = Country.create(name: params[:name])
    @traveler.countries << @countries
      redirect '/countries'
    else
      redirect '/countries/new'
    end
  end

  get '/countries/:id' do
    @country = Country.find_by(id: params[:id])
    if logged_in?
      @traveler = current_user
      erb :'countries/show'
    else
      redirect '/'
    end
  end

  get '/countries/:id/edit' do
    @countries = Country.find_by(id: params[:id])
    if logged_in? && @Country.traveler == current_user
      erb :'countries/edit'
    else
      redirect '/'
    end
  end

  patch '/countries/:id' do
    @country = Country.find_by_id(params[:id])
    if logged_in? && @country.user == current_user && !params[:name].empty?
      @traveler = current_user
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
    if logged_in? && @traveler.traveler == current_user
      @country.delete
      redirect '/countries'
    else
      redirect "/countries/#{@country.id}"
    end
  end
end
