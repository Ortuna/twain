describe 'authentication' do
  before :each do
    clear_cookies
    Helper.clean_users
    Helper.create_user('apiuser', 'apipassword')

    @login_end_point  = '/login'
    @logout_end_point = '/logout'
  end

  it 'authenticates a user correctly' do
    params = { username: 'apiuser', password: 'apipassword' }
    post @login_end_point, params

    user = Helper.parse_json(last_response.body)
    user["username"].should == params[:username]

    last_response.should be_ok
  end

  it 'denies login with invalid username and pass' do
    params = { username: 'apiuser', password: 'apipasswordzzz' }
    post @login_end_point, params

    last_response.should_not be_ok
  end

  it 'denies without params' do
    post @login_end_point
    last_response.should_not be_ok
  end

  it 'logs you out when visiting logout end point' do
    params = { username: 'apiuser', password: 'apipassword' }
    post @login_end_point, params
    last_response.should be_ok

    get '/api/book'
    last_response.should be_ok

    get @logout_end_point
    last_response.should be_ok

    get '/api/book'
    last_response.should_not be_ok
  end
end