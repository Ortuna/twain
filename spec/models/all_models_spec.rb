describe 'models' do
  before :each do
    @remote_repo = "#{SPEC_PATH}/fixture/books"
    @tmp_path    = "/tmp/books"
    DataMapper.setup(:gitfs, "gitfs:://#{@tmp_path}?#{@remote_repo}")
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
end