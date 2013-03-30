describe 'api' do

  def setup_api(git_path)
    Twain::API.new(git: git_path)
  end

  describe 'setup' do
  
    before :each do 
      @git_path = "#{SPEC_PATH}/fixture/books#local-only"
      @api      = setup_api @git_path
    end

    after :each do
      @api.clean!
    end


    it 'sets options correctly' do
      @api.git_location.should  == @git_path
      @api.options[:git].should == @git_path
    end
  
    it 'sets the local_path variable' do
      @api.local_path.should_not be_nil
      @api.local_path.should_not be_empty
    end

    it 'cleans up with clean!' do
      @api.clean!
      File.exists?(@api.local_path).should == false
    end

    # xit 'fails with an invalid git path' do
    #   expect {setup_api('xyz repo')}.to raise_error
    # end

    # xit 'authenticates user'

  end


end