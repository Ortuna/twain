Twain::App.controllers do

  post '/authenticate', :csrf_protection => false do
    username = params[:username] || nil
    password = params[:password] || nil
    user     = User.authenticate(username, password)
    user ? user.to_json : response.status = 403
  end

end
