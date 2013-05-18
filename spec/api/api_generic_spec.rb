describe Mori::API do

  def setup_api(git_path)
    Helper.setup_api(git_path, 'apiuser', 'apipassword')
  end

  describe 'basics' do
    before :each do
      @git_path = "#{SPEC_PATH}/fixture/books#local-only"
      @api      = setup_api @git_path
    end

    after :each do
      @api.clean!
      Helper.clean_users
    end

    it 'sets options correctly' do
      @api.git_location.should  == @git_path
      @api.options[:git].should == @git_path
    end
  
    it 'sets the local_path variable' do
      @api.local_path.should_not be_nil
      @api.local_path.should_not be_empty
    end

    it 'cleans up with clean!' do
      @api.clean!
      File.exists?(@api.local_path).should == false
    end

    it 'fails with an invalid git path' do
      expect {setup_api('xyz repo')}.to raise_error
    end

    it 'fails with a invalid login' do
      expect {
        Twain::API.new(git: @git_path,
                    prefix: Helper.tmp_prefix,
                  username: 'unkownapiuser',
                  password: 'unknownpassword')
      }.to raise_error
    end

    it 'allows api with a user object' do
      Helper.clean_users
      user = Helper.create_user('username', 'password')
      expect {
        Twain::API.new(git: @git_path,
                    prefix: Helper.tmp_prefix,
                      user: user)
      }.to_not raise_error
    end

    it 'fails with a bad user' do
      user = {}
      expect {
        Twain::API.new(git: @git_path,
                    prefix: Helper.tmp_prefix,
                      user: user)
      }.to raise_error
    end
  end

  describe 'restricted areas' do
    def login(username, password) 
      post '/login', { username: username, password: password }
    end

    before :each do
      Helper.clean_users
      clear_cookies
    end

    it 'should block api to logged in users only' do
      get '/books'
      last_response.status.should == 403
    end

    it 'should block api to logged in users only deux' do
      username, password = 'apiuserz', 'apipasswordz'
      Helper.create_user(username, password)
      login(username, 'password')

      get '/books'
      last_response.status.should == 403
    end

    it 'should not block api if logged in' do
      username, password = 'testuser', 'temp'
      Helper.create_user(username, password)
      login(username, password)
      get '/books'
      last_response.status.should == 200
    end
    
  end

end