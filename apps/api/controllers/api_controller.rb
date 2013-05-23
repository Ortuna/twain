class API::App

  include Mori::Common
  include Mori::Util

  def to_json(object, root = false)
    root = root.to_s if root
    #TODO: deal with to_json => to_s conversion, should just be to_json
    if object.respond_to? :each
      ActiveModel::ArraySerializer.new(object, :root => root).as_json
    else
      { root => ActiveModel::DefaultSerializer.new(object).serializable_hash }
    end.to_json
  end
end

API::App.controllers :books do

  get :index do
    to_json(Repo.all, :books)
  end

  get ':book_id' do |book_id|
    setup_api(book_id)
    book            = api.current_book.as_json
    book[:chapters] = to_json(api.current_book.chapters)
    {book: book}.to_json
  end

  get ':book_id/chapters' do |book_id|
    setup_api(book_id)
    to_json(api.current_book.chapters, :chapters)
  end

  get ':book_id/chapters/:chapter_id/sections' do |book_id, chapter_id|
    to_json(find_chapter(book_id, chapter_id).sections, :sections)
  end

  get ':book_id/chapters/:chapter_id/sections/:section_id' do |book_id, chapter_id, section_id|
    to_json(find_section(book_id, chapter_id, section_id), :section)
  end

  post ':book_id/chapters/:chapter_id/sections' do |book_id, chapter_id|
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

  post ':book_id/chapters/:chapter_id' do |book_id, chapter_id|
    setup_api(book_id)
    post_chapter = parse_json(params["chapter"])

    invalid_entity if !post_chapter || post_chapter.empty?

    chapter = find_chapter(book_id, post_chapter["base_path"])
    update_attributes(chapter, post_chapter)
    chapter.save if chapter.dirty?
  end

  delete ':book_id/chapters/:chapter_id' do |book_id, chapter_id|
    setup_api(book_id)
    chapter = book.chapters.first(:base_path => chapter_id)
    invalid_entity if chapter.destroy == false
  end

  post ':book_id/chapters/:chapter_id/sections/:section_id' do |book_id, 
                                                              chapter_id, 
                                                              section_id|
    setup_api(book_id)
    section      = find_section(book_id, chapter_id, section_id)

    post_section = parse_json(params["section"])

    invalid_entity unless post_section

    #TODO: Do something else but good for now
    if params["section"]["metadata"]
      params["section"]["metadata"] = YAML::load(params["section"]["metadata"]) 
    end
    
    update_attributes(section, post_section)

    section.save if section.dirty?
  end

  delete ':book_id/chapters/:chapter_id/sections/:section_id' do |book_id, 
                                                                chapter_id, 
                                                                section_id|
    setup_api(book_id)
    section = find_section(book_id, chapter_id, section_id)
    invalid_entity if section.destroy == false
  end
end
