class API::App

  get :login do 
    session[:user] = User.first
  end

  post :login do
    username = params[:username] || nil
    password = params[:password] || nil
    user     = authenticate_user(username, password)
    user ? user.to_json : halt(403, 'invalid login')
  end

  get(:logout) { logout }
  post(:logout) { logout }
  
  private
  def logout
    session.clear
    'logged out'
  end
  def authenticate_user(username, password)
    User.authenticate(username, password).tap { |user| session[:user] = user }
  end
end
