class Twain::App

  def find_repo(book_id)
    Repo.first(:id => book_id.to_i) || halt(404)
  end

  def create_api(repo_location, user)
    Twain::API.new(git: repo_location, prefix: '/tmp', user: user)
  end

  before do
    if request.path_info[/\A\/api/]
      halt(403, 'login required') unless session[:user]
    end
  end

  get '/api/books' do
    Repo.all.to_json
  end

  get '/api/book/:book_id' do |book_id|
    repo = find_repo(book_id)
    api  = create_api(repo[:location], session[:user])
    api.current_book.to_json
  end

  get '/api/book/:book_id/chapters' do |book_id|
    repo = find_repo(book_id)
    api  = create_api(repo[:location], session[:user])
    api.current_book.chapters.to_json
  end

  get '/api/book/:book_id/chapter/:chapter_id/sections' do |book_id, chapter_id|
    repo    = find_repo(book_id)
    api     = create_api(repo[:location], session[:user])
    chapter = api.current_book.chapters.first(:base_path => chapter_id)
    chapter.sections.to_json
  end

end
