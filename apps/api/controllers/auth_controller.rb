class API::App
  register Padrino::Admin::AccessControl
  register Padrino::Admin::AccessHelpers
  set :admin_model, 'User'

  allow_paths %w[/]
  before do
    # halt(403, 'login required') unless current_account
  end
end