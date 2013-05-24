describe 'Mori::API' do
  describe Mori::App do
    let(:app) { Mori::App }

    it 'redirect unauthenticated users' do
      get '/books'
      last_response.status.should == 302
    end

    it 'allows authenticated users' do
      omniauth_login
      get '/books'
      last_response.status.should == 200
    end

  end

end
