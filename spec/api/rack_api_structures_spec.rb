describe Mori::API do

  before :each do
    clear_cookies
    Helper.clear_all

    @repo_location = "#{SPEC_PATH}/fixture/books/sample_book#local-only"

    #Create a repo to point to
    omniauth_login
    repo = Helper.create_repo(User.first[:id], @repo_location)
  end

  it 'gets a list of books' do
    get api_prefix
    last_response.should be_ok
    books = Helper.parse_json(last_response.body)["books"]
    books.first["location"].should_not be_nil
  end

  it 'fails on an invalid book' do
    get "#{api_prefix}/das_book"
    last_response.status.should == 404
  end

  it 'gets information on a book' do
    book_id = get_repo_list.first["id"]
    book_id.should_not be_nil

    get "#{api_prefix}/#{book_id}"
    last_response.should be_ok
    book = Helper.parse_json(last_response.body)["book"]

    book["base_path"].should_not be_nil
  end

  it 'gets all the chapters in a book' do
    book_id = get_repo_list.first["id"]
    book_id.should_not be_nil
    get "#{api_prefix}/#{book_id}/chapters"
    last_response.should be_ok

    chapters = Helper.parse_json(last_response.body)["chapters"]
    chapters.count.should be > 1

    chapters.first['title'].should_not be_nil
  end

  it 'gets all the sections on a book and chapter' do
    book_id    = get_repo_list.first["id"]

    get "#{api_prefix}/#{book_id}/chapters"
    chapter_id = Helper.parse_json(last_response.body)["chapters"].first["base_path"]

    get "#{api_prefix}/#{book_id}/chapters/#{chapter_id}/sections"
    last_response.should be_ok

    sections = Helper.parse_json(last_response.body)["sections"]
    sections.first["metadata"]["title"].should_not be_nil
  end

  it 'gets a section' do
    book_id    = get_repo_list.first["id"]

    get "#{api_prefix}/#{book_id}/chapters"
    chapter_id = Helper.parse_json(last_response.body)["chapters"].first["base_path"]

    get "#{api_prefix}/#{book_id}/chapters/#{chapter_id}/sections"
    section_id = Helper.parse_json(last_response.body)["sections"].first["base_path"]
    
    get "#{api_prefix}/#{book_id}/chapters/#{chapter_id}/sections/#{section_id}"
    last_response.should be_ok

    section = Helper.parse_json(last_response.body)["section"]
    section["metadata"]["title"].should_not be_nil
  end
end
