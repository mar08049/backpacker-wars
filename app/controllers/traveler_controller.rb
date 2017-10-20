class TravelerController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'/signup'
    else
      @traveler = current_user
      session[:user_id] = @traveler.id
      redirect "/travelers/#{@traveler.slug}"
    end
  end

  post '/signup' do
    if params["username"] != "" && params[:email] != "" && params[:password] != ""
    @traveler = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = @traveler.id
    redirect "/travelers/#{@traveler.slug}"
    else
      erb :'/signup'
    end
  end

  get '/login' do
    if !logged_in?
    erb :'/login'
    else
      @traveler = current_user
      session[:user_id] = @traveler.id
      redirect "/travelers/#{@traveler.slug}"
    end
  end

  post '/login' do
      @traveler = Traveler.find_by(username: params[:username])
      if @traveler && @traveler.authenticate(params[:password])
        session[:user_id] = @traveler.id
        redirect "/travelers/#{@traveler.slug}"
      else
        redirect '/login'
      end
  end

  get '/travelers/:slug' do
    @traveler = Traveler.find(params[:slug])
    @traveler = current_user
    if current_user
       erb :'/show'
     else
       redirect '/countries'
     end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
