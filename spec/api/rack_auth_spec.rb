describe 'Mori::API' do
  def login
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] =  { 'provider'     => 'github', 
                                            'access_token' => '123', 
                                            'uid'          => '123545',
                                            'info' => {'name'  => 'test',
                                                       'image' => 'test' }
                                          }
    get '/auth/github'
    follow_redirect!
  end

  describe Mori::App do
    let(:app) { Mori::App }

    it 'redirect unauthenticated users' do
      get '/books'
      last_response.status.should == 302
    end

    it 'allows authenticated users' do
      login
      get '/books'
      last_response.status.should == 200
    end

  end

end