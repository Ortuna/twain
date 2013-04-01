describe Twain::API do

  def login(username, password)
    params = { username: username, password: password }
    post '/login', params
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

  def get_repo_list
    get '/api/books'
    Helper.parse_json(last_response.body)
  end

  it 'gets a list of books' do
    get '/api/books'
    last_response.should be_ok
    books = Helper.parse_json(last_response.body)
    books.first["location"].should_not be_nil
  end

  it 'fails on an invalid book' do
    get "/api/book/das_book"
    last_response.status.should == 404
  end

  it 'gets information on a book' do
    book_id = get_repo_list.first["id"]
    book_id.should_not be_nil

    get "/api/book/#{book_id}"
    last_response.should be_ok

    book = Helper.parse_json(last_response.body)
    book["base_path"].should_not be_nil
  end
end