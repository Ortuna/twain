class Twain::App

  before do
    if request.path_info[/\A\/api/]
      halt(403, 'login required') unless session[:user]
    end
  end

  get '/api/books' do
    Repo.all.to_json
  end

  get '/api/book/:book_id' do |book_id|
    repo = Repo.first(:id => book_id.to_i)
    halt 404 unless repo
    @api = Twain::API.new(git:    repo[:location],
                          prefix: '/tmp',
                          user:   session[:user])

    @api.current_book.to_json
  end

  get '/api/book/:book_id/chapters' do |book_id|
    repo = Repo.first(:id => book_id.to_i)
    halt 404 unless repo
    @api = Twain::API.new(git:    repo[:location],
                          prefix: '/tmp',
                          user:   session[:user])
    @api.current_book.chapters.to_json    
  end

end
