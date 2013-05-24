describe Mori::API do

  describe 'basics' do
    before :each do
      @repo_location = "#{SPEC_PATH}/fixture/books/sample_book#local-only"
      @api      = setup_api @repo_location
    end

    after :each do
      @api.clean!
      Helper.clean_users
    end

    it 'sets options correctly' do
      @api.git_location.should  == @repo_location
      @api.options[:git].should == @repo_location
    end
  
    it 'sets the local_path variable' do
      @api.local_path.should_not be_nil
      @api.local_path.should_not be_empty
    end

    it 'cleans up with clean!' do
      @api.clean!
      File.exists?(@api.local_path).should == false
    end

    it 'fails with an invalid git path' do
      expect {setup_api('xyz repo')}.to raise_error
    end
  end
  
end
