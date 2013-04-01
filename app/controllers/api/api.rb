class Twain::App

  before do
    if request.path_info[/\A\/api/]
      halt(403, 'login required') unless session['user']
    end
  end

  get '/api/book' do
    'done'
  end
end
