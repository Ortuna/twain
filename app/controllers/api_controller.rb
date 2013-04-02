class Twain::App

  include Twain::Common
  include Twain::Util

  before do
    check_login if request.path_info[/\A\/api/]
  end

  get '/api/books' do
    Repo.all.to_json
  end

end

Twain::App.controllers '/api/book' do

  get ':book_id' do |book_id|
    setup_api(book_id)
    api.current_book.to_json
  end

  get ':book_id/chapters' do |book_id|
    setup_api(book_id)
    api.current_book.chapters.to_json
  end

  get ':book_id/chapter/:chapter_id/sections' do |book_id, chapter_id|
    find_chapter(book_id, chapter_id).sections.to_json
  end

  post ':book_id/chapter/:chapter_id/sections' do |book_id, chapter_id|
    chapter      = find_chapter(book_id, chapter_id)
    post_section = parse_json(params["section"])

    section = Section.new
    section.base_path = post_section["base_path"]
    section.chapter   = chapter

    invalid_entity unless section.save
  end

  post ':book_id' do |book_id|
    setup_api(book_id)
    post_book = parse_json(params["book"])

    invalid_entity if !post_book || post_book.empty?

    update_attributes(book, post_book)
    book.save if book.dirty?
  end

  post ':book_id/chapters' do |book_id|
    setup_api(book_id)
    post_chapter = parse_json(params["chapter"])

    invalid_entity if post_chapter.empty?

    chapter           = Chapter.new
    chapter.base_path = post_chapter["base_path"]
    chapter.book      = book
    invalid_entity unless chapter.save
  end

  post ':book_id/chapter/:chapter_id' do |book_id, chapter_id|
    setup_api(book_id)
    post_chapter = parse_json(params["chapter"])

    invalid_entity if !post_chapter || post_chapter.empty?

    chapter = find_chapter(book_id, post_chapter["base_path"])
    update_attributes(chapter, post_chapter)
    chapter.save if chapter.dirty?
  end

  delete ':book_id/chapter/:chapter_id' do |book_id, chapter_id|
    setup_api(book_id)
    chapter = book.chapters.first(:base_path => chapter_id)
    invalid_entity if chapter.destroy == false
  end

  post ':book_id/chapter/:chapter_id/section/:section_id' do |book_id, 
                                                              chapter_id, 
                                                              section_id|
    setup_api(book_id)
    section      = find_section(book_id, chapter_id, section_id)
    post_section = parse_json(params["section"])

    invalid_entity unless post_section
    update_attributes(section, post_section)
    section.save if section.dirty?
  end

  delete ':book_id/chapter/:chapter_id/section/:section_id' do |book_id, 
                                                                chapter_id, 
                                                                section_id|
    setup_api(book_id)
    section = find_section(book_id, chapter_id, section_id)
    invalid_entity if section.destroy == false
  end
end