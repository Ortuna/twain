describe Mori::API do

  def setup_api(git_path)
    Helper.setup_api(git_path, 'apiuser')
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

    it 'should check authentication'
  end

  
  describe 'restricted areas' do
    def login(username, password) 
      post '/login', { username: username, password: password }
    end

    before :each do
      Helper.clean_users
      clear_cookies
    end

    it 'should not block api if logged in' do
      username, password = 'testuser', 'temp'
      Helper.create_user(username)
      login(username, password)
      get '/books'
      last_response.status.should == 200
    end
    
  end

end
