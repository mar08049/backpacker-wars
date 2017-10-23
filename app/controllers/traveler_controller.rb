class TravelerController < ApplicationController

  get '/signup' do
    if !logged_in?#if user not logged on, go to signup page.
    erb :'/travelers/signup'
    else
      @traveler = current_user#if user is logged on, redirect to show page or user profile page.
      session[:traveler_id] = @traveler.id
      redirect "/travelers/#{@traveler.slug}"
    end
  end

  post '/signup' do
    if params["username"] != "" && params[:email] != "" && params[:password] != ""
    @traveler = Traveler.create(username: params[:username], email: params[:email], password: params[:password])
    session[:traveler_id] = @traveler.id#if params are filled in correctly, redirect to user profile page.(show)
    redirect "/travelers/#{@traveler.slug}"
    else
      erb :'/travelers/sign_up'#if not, stay at sign_up page.
    end
  end

  get '/login' do
    if !logged_in?#if not logged in, go to login page.
    erb :'/travelers/login'
    else
      @traveler = current_user#if logged in, redirect to user profile page(show).
      session[:traveler_id] = @traveler.id
      redirect "/travelers/#{@traveler.slug}"
    end
  end

  post '/login' do
      @traveler = Traveler.find_by(username: params[:username])
      if @traveler && @traveler.authenticate(params[:password])
        session[:traveler_id] = @traveler.id#if user is user and is authenticated via password, go to user profile(show).
        redirect "/travelers/#{@traveler.slug}"
      else
        redirect '/failure'#if not, go to failure page, with option to return to login.
      end
  end

  get '/travelers/:slug' do
    @traveler = Traveler.find_by_slug(params[:slug])
    @traveler = current_user #show "show" page only if current user is logged in.
    if current_user
       erb :'/travelers/show'
     else
       redirect '/countries'
     end
  end

  get '/logout' do
    session.clear#clear session and go back to route page.
    redirect '/'
  end
end
