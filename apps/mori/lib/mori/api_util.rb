module Mori::Util
  attr_reader :api

  def setup_request(book_id)
    repo = find_repo(book_id)
    create_api(repo[:location], session[:user])
  end

  def setup_api(book_id)
    @api ||= setup_request(book_id)
  end

  def book
    api.current_book
  end

  def find_section(book_id, chapter_id, section_id)
    setup_api(book_id)
    chapter   = book.chapters.first(:base_path => chapter_id)
    not_found unless chapter
    
    chapter.sections.first(:base_path => section_id).tap do |section|
      not_found unless section
    end
  end

  def find_chapter(book_id, chapter_id)
    setup_api(book_id)
    book.chapters.first(:base_path => chapter_id).tap do |chapter|
      not_found unless chapter
    end
  end

  def find_repo(book_id)
    Repo.first(:id => book_id.to_i) || halt(404)
  end
end