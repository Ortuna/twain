describe 'Twain::API books' do
  def setup_api(git_path)
    Helper.setup_api(git_path, 'apiuser', 'apipassword')
  end

  before :each do 
    @git_path = "#{SPEC_PATH}/fixture/books#local-only"
    @api      = setup_api @git_path
  end

  after :each do
    @api.clean!
  end

  it 'returns a list of books' do
    books = @api.book.all_books
    books.should_not be_empty
  end

  it 'returns the base path of books' do
    book = @api.book.all_books.first
    book.base_path.should_not be_nil
  end

  it 'should find a book by its base path' do
    real_book = @api.book.all_books.first
    book = @api.book.find_book real_book.base_path
    book.should_not be_empty
    book.base_path.should == real_book.base_path
  end

  it 'should find a book by its title' do
    real_book = @api.book.all_books.first
    real_book.rename('to Be or Not to be')
    @api.book.find_book('to Be or Not to be').should_not be_nil
  end

  it 'gives an empty array if book is not found' do
    @api.book.find_book('non-existing book').should be_nil
  end

  it 'should rename a book' do
    new_title = 'this new title'
    book      = @api.book.all_books.first
    book.rename(new_title).should == true

    book = @api.book.find_book(new_title)
    book.should_not be_nil
    book.base_path.should == 'this-new-title'
    book.title.should     == 'this new title'
  end

  it 'should not rename if name already exists'

end