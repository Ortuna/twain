describe 'models' do
  before :each do
    @remote_repo = "#{SPEC_PATH}/fixture/books"
    @tmp_path    = "#{Helper.tmp_prefix}/books"
    DataMapper.setup(:gitfs, "gitfs:://#{@tmp_path}?#{@remote_repo}##local-only")
  end

  after :each do
    FileUtils.rm_rf @tmp_path
  end

  describe 'sanity check' do
    
    it 'finds a book' do
     Book.first.should_not be_nil
    end
    
    it 'find all its chapters' do
      chapters = Book.first.chapters
      chapters.should_not be_empty
      chapters.count.should be > 0
    end

    it 'finds its sections' do
      sections = Chapter.first.sections
      sections.should_not be_empty
      sections.count.should be > 0
    end
    
    it 'finds the sections' do
      sections = Book.first.chapters.first.sections
      sections.should_not be_empty

      sections.count.should be > 1
    end

    it 'loads metadata' do 
      section = Book.first.chapters.first.sections.first
      section.metadata.should_not be_nil
    end

  end

  describe 'book' do
    
    it 'has a working title field' do
      book = Book.first
      book.title = "Awesome title"
      book.save

      Book.first(:title => "Awesome title").should_not be_nil
    end

    it 'renames itself correctly' do
      book = Book.first
      book.base_path = 'xyz'
      book.save

      Book.first(:base_path => 'xyz').should_not be_nil
    end

    it 'renames both title and basepath on rename' do
      book = Book.first
      book.rename('This new title')
      Book.first(:base_path => 'this-new-title').should_not be_nil
      Book.first(:title => 'This new title').should_not be_nil
      Book.first(:title => 'This new Title').should be_nil
    end

  end

  describe 'chapter' do

    it 'has a working title field which defaults to base_path' do
      chapters = Book.first.chapters
      chapters.first.title.should_not == chapters.first.base_path
      chapters.last.title.should      == chapters.last.base_path
    end

  end
end