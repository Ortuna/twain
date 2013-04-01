class Twain::App

  before do
    check_login if request.path_info[/\A\/api/]
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


  post '/api/book/:book_id', :csrf_protection => false do |book_id|
    repo      = find_repo(book_id)
    api       = create_api(repo[:location], session[:user])
    book      = api.current_book
    post_book = parse_json(params["book"])

    halt(422) unless post_book
    halt(422) if post_book.empty?

    update_attributes(book, post_book)
    book.save if book.dirty?
  end

  post '/api/book/:book_id/chapter/:chapter_id', 
    :csrf_protection => false do |book_id, chapter_id|
    repo      = find_repo(book_id)
    api       = create_api(repo[:location], session[:user])
    book      = api.current_book

    post_chapter = parse_json(params["chapter"])
    halt(422) unless post_chapter
    halt(422) if post_chapter.empty?

    chapter   = book.chapters.first(:base_path => post_chapter["base_path"])
    halt(404) unless chapter

    update_attributes(chapter, post_chapter)
    chapter.save if chapter.dirty?
  end

  post '/api/book/:book_id/chapter/:chapter_id/section/:section_id',
    :csrf_protection => false do |book_id, chapter_id, section_id|
    repo      = find_repo(book_id)
    api       = create_api(repo[:location], session[:user])
    book      = api.current_book

    chapter   = book.chapters.first(:base_path => chapter_id)
    halt(404) unless chapter

    post_section = parse_json(params["section"])
    halt(422) unless post_section
    
    section = chapter.sections.first(:base_path => section_id)
    halt(404) unless section

    update_attributes(section, post_section)
    section.save if section.dirty?
  end

end
