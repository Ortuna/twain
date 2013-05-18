class FrontEnd::App
  layout :site

  get :login, map: '/login' do
    render :login
  end
end