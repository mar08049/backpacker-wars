class CountryController < ApplicationController

  get '/countries' do
    if logged_in?
      @traveler = current_user
      @countries = Country.all
      erb :'countries/index'
    else
      redirect '/login'
    end
  end

  get '/countries/new' do
    @country = Country.find_by(id: params[:id])
    if logged_in?
      @country = current_user
      erb :'countries/new'
    else
      redirect '/login'
    end
  end

  post '/countries' do
    @country = current_user
    if logged_in? && !params[:content].empty?
    @country = Country.create(content: params[:content])
    @country.countries << @countries
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
      redirect '/login'
    end
  end

  get '/countries/:id/edit' do
    @countries = Country.find_by(id: params[:id])
    if logged_in? && @Country.user == current_user
      erb :'countries/edit'
    else
      redirect '/login'
    end
  end

  patch '/countries/:id' do
    @country = Country.find_by_id(params[:id])
    if logged_in? && @country.user == current_user && !params[:content].empty?
      @traveler = current_user
      @country.update(content: params[:content])
      @country.save
      redirect "/countries/#{@country.id}"
    else
      redirect "/countries/#{@country.id}/edit"
    end
  end

  delete '/countries/:id/delete' do
    @country = Country.find_by_id(params[:id])
    @traveler = current_user
    if logged_in? && @traveler.user == current_user
      @country.delete
      redirect '/countries'
    else
      redirect "/countries/#{@country.id}"
    end
  end
end
