describe 'api for books' do
  def setup_api(git_path)
    Twain::API.new(git: git_path)
  end

  before :each do 
    @git_path = "#{SPEC_PATH}/fixture/books#local-only"
    @api      = setup_api @git_path
  end

  after :each do
    @api.clean!
  end

  it 'returns a list of books' do
    books = @api.all_books
    books.should_not be_empty
  end

  it 'returns the base path of books' do
    book = @api.all_books.first
    book.base_path.should_not be_nil
  end

  it 'should find a book by its base path' do
    real_book = @api.all_books.first
    book = @api.find_book real_book.base_path
    book.should_not be_empty
    book.base_path.should == real_book.base_path
  end

  it 'should find a book by its title' do
    real_book = @api.all_books.first
    real_book.rename('to Be or Not to be')
    @api.find_book('to Be or Not to be').should_not be_nil
  end

  it 'gives an empty array if book is not found' do
    @api.find_book('non-existing book').should be_nil
  end

  it 'should rename a book' do
    new_title = 'this new title'
    book      = @api.all_books.first
    @api.rename(book, new_title)

    book = @api.find_book(new_title)
    book.should_not be_nil
    book.base_path.should == 'this-new-title'
    book.title.should     == 'this new title'
  end
end