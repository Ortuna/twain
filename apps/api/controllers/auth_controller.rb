class API::App
  register Padrino::Admin::AccessControl
  set :admin_model, 'User'

  before do
    # halt(403, 'login required') unless current_account
  end
end