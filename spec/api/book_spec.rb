describe 'book' do

  it 'Should get a list of books at root path' do
    get '/book'
    last_response.should be_ok

    books = parse_json(last_response.body)
    books.should_not be_empty
  end

end