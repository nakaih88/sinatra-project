require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Anime_Sinatra_App"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def redirect_if_not_authorized(anime)
      if !logged_in? || anime.user != current_user
       redirect '/'
      end
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

end
