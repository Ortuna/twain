describe 'Mori::API' do
  
  let(:app) { Mori::App}

  it 'blocks non authenticated users' do
    get '/books'
    last_response.status.should == 302
  end

  describe 'mock user' do
    before :each do
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:github, { :provider => 'github', :uid => '123545' })
    end

    it 'allows authenticated users' do
      env = { "omniauth.auth" => { "provider" => 'github', "uid" => '123545' } }
      get '/books', {}, env
      last_response.status.should == 200
    end

  end
end
