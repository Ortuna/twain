class Twain::App

  post '/authenticate', :csrf_protection => false do
    username = params[:username] || nil
    password = params[:password] || nil
    user     = authenticate_user(username, password)
    user ? user.to_json : response.status = 403
  end

  private
  def authenticate_user(username, password)
    User.authenticate(username, password).tap { |user| session[:user] = user }
  end
end
