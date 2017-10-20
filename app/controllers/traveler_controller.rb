class TravelerController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'travelers/new'
    else
      redirect 'travelers/welcome'
    end
  end

  post '/signup' do
    if params["username"] != "" && params["email"] != "" && params["password"] != ""
    @traveler = Traveler.create(username: params['username'], email: params['email'], password: params['password'])
    session[:user_id] = @traveler.id
    redirect to '/travelers'
    else
    redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/travelers'
    else
      erb :'travelers/login'
    end
  end

  post '/login' do
    @traveler = Traveler.find_by(username: params[:username])
    if @traveler && @traveler.authenticate(params[:password])
      session[:user_id] = @traveler.id
      redirect '/travelers'
    else
      redirect 'login'
    end
  end

  get '/travelers/:slug' do
    @traveler = Traveler.find_by_slug(params[:slug])
    erb :'/travelers/show'
  end

  get '/logout' do
    if logged_in?
    session.clear
    redirect '/login'
    end
    redirect '/'
  end
end
