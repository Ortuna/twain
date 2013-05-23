describe 'Mori::API' do
  
  xit 'blocks non authenticated users' do
    get '/books'
    last_response.status.should == 302
  end

  describe 'mock user' do
    before :each do
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:github, { :provider => 'github', :uid => '123545' })
    end

    xit 'allows authenticated users' do
      get '/books', {}, {"omniauth.auth" => OmniAuth.config.mock_auth[:github] }
      binding.pry
      last_response.status.should == 200
    end

  end
end