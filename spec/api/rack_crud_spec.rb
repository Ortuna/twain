describe Twain::API do

  def login(username, password)
    params = { username: username, password: password }
    post '/login', params
  end

  def get_repo_list
    get_json_from '/api/books'
  end

  def get_first_book
    get_json_from "/api/book/#{get_repo_list.first["id"]}"
  end

  def get_first_chapter
    get_json_from("/api/book/#{get_repo_list.first["id"]}/chapters").first
  end

  def get_json_from(url)
    get url
    Helper.parse_json(last_response.body)
  end

  before :each do
    clear_cookies
    Helper.clear_all

    @repo_location = "#{SPEC_PATH}/fixture/books#local-only"

    #Create a user
    username, password = 'apiuser', 'temp'
    user = Helper.create_user(username, password)

    #Create a repo to point to
    repo = Helper.create_repo(user[:id], @repo_location)

    login(username, password)
  end

  after :each do
    FileUtils.rm_rf Helper.tmp_prefix
  end

  describe 'book' do
    it 'rejects unknown books' do
      post "/api/book/xyz", {book: {} }
      last_response.should_not be_ok
    end

    it 'updates a book record' do
      new_title     = "This awesome book #{Time.now}"
      book          = get_first_book
      book["title"] = new_title
      
      post "/api/book/#{get_repo_list.first['id']}", { book: book.to_json }
      last_response.should be_ok

      book = get_first_book
      book["title"].should == new_title
    end
  end

  describe 'chapter' do
    it 'updates a chapter record' do
      new_title = "Chapter of chapters #{Time.now}"
      chapter   = get_first_chapter
      chapter["title"] = new_title

      post_url =  "/api/book/#{get_repo_list.first['id']}"
      post_url << "/chapter/#{chapter['base_path']}"

      post post_url, { chapter: chapter.to_json }
      last_response.should be_ok

      chapter = get_first_chapter
      chapter["title"].should == new_title
    end

    it 'rejects unknown chapters' do
      chapter  = get_first_chapter
      post_url =  "/api/book/#{get_repo_list.first['id']}"
      post_url << "/chapter#{chapter['base_path']}"

      post post_url, { chapter: {} }
      last_response.should_not be_ok

      post post_url, { chapter: { base_path: 'xyzpath' } }
      last_response.should_not be_ok      
    end

    it 'creates new chapters' do
      chapters_path =  "/api/book/#{get_repo_list.first['id']}/chapters"

      chapter = Chapter.new
      chapter.base_path = 'new_chapter'
      
      post chapters_path, {chapter: chapter.to_json}
      last_response.should be_ok

      get_json_from(chapters_path).inject([]) do |memo, chapter| 
        memo.tap { |m| m << chapter["base_path"] }
      end.should include('new_chapter')
    end

    it 'deletes a chapter' do
      chapter_id    = 'cool_chapter'
      delete_url    = "/api/book/#{get_repo_list.first['id']}/chapter/#{chapter_id}"
      chapters_path = "/api/book/#{get_repo_list.first['id']}/chapters"

      #create a chapter
      chapter           = Chapter.new
      chapter.base_path = chapter_id
      post chapters_path, {chapter: chapter.to_json}
      last_response.should be_ok

      #delete it
      delete delete_url

      last_response.should be_ok

      get_json_from(chapters_path).inject([]) do |memo, chapter| 
        memo.tap { |m| m << chapter["base_path"] }
      end.should_not include(chapter_id)

    end

  end#chapter

  describe 'sections' do
    it 'updates a section record' do
      new_title = "The now section #{Time.now}"
      chapter   = get_first_chapter
      section_list_url =  "/api/book/#{get_repo_list.first['id']}"
      section_list_url << "/chapter/#{chapter['base_path']}/sections"

      section = get_json_from(section_list_url).first

      post_url =  "/api/book/#{get_repo_list.first['id']}"
      post_url << "/chapter/#{chapter['base_path']}/section/#{section['base_path']}"

      section["title"] = new_title

      post post_url, { section: section.to_json }
      last_response.should be_ok

      section = get_json_from(section_list_url).first

      section["title"].should == new_title
    end
  end

end