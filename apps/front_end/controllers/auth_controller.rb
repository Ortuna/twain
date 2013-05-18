class FrontEnd::App
  layout :site
  before except: [:login, :logout] do
    check_login
    @user = session[:user]
  end

  get :login, map: '/login' do
    render :login
  end

  post :login, map: '/login' do
    username = params[:username]
    password = params[:password]
    user     = authenticate_user(username, password)
    if user
      redirect '/books'
    else
      halt(403, 'invalid login')
    end
  end

  get(:logout)  { logout }
  post(:logout) { logout }
  
  private
  def check_login
    redirect '/login' unless logged_in?
  end

  def logged_in?
    session[:user] ? true : false
  end

  def logout
    session.clear
    'logged out'
  end
  def authenticate_user(username, password)
    User.authenticate(username, password).tap { |user| session[:user] = user }
  end
   
end