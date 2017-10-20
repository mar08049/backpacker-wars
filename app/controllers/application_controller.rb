require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'fwitter_secret'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def current_user
      Traveler.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
