class Mori::App
  register Padrino::Admin::AccessControl
  register Padrino::Admin::AccessHelpers
  enable :sessions
  
  #access
  set :login_page,  '/login'
  set :admin_model, 'User'
  
  protect_paths %w[/ /api]
  allow_paths   %w[/login /logout /auth/github /auth/github/callback]
  
  #providers
  use OmniAuth::Builder do
    provider :github, '2e0806ae149248209186', '5cb5a931148f01de4698920cbabe67e6a0034488', scope: "user,repo"
  end

  get :auth, :map => '/auth/:provider/callback' do
    auth    = request.env["omniauth.auth"]
    account = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    account ? redirect_and_set_current_account(account) : redirect_auth_failed
  end

  get :login, :map => '/login'do
    render :login
  end
  
  get :logout, :map => '/logout' do
    set_current_account(nil)
    redirect url(:index)
  end

  get :failed_auth, :map => '/failed' do
    "Failed auth"
  end

  private
  def redirect_auth_failed
    redirect_local url(:failed_auth)
  end

  def redirect_and_set_current_account(account)
    set_current_account(account)
    redirect_local '/books'
  end

  def redirect_local(to)
    redirect "http://" + request.env["HTTP_HOST"] + to
  end
end
