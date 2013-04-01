describe 'authentication' do
  before :each do
    clear_cookies
    Helper.clean_users
    Helper.create_user('apiuser', 'apipassword')
  end

  it 'authenticates a user correctly' do
    params = { username: 'apiuser', password: 'apipassword' }
    post '/authenticate', params

    user = Helper.parse_json(last_response.body)
    user["username"].should == params[:username]

    last_response.should be_ok
  end

  it 'denies login with invalid username and pass' do
    params = { username: 'apiuser', password: 'apipasswordzzz' }
    post '/authenticate', params

    last_response.should_not be_ok
  end

  it 'denies without params' do
    post '/authenticate'
    last_response.should_not be_ok
  end
end