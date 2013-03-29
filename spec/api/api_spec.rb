describe 'api' do

  before :each do
    @remote_repo = "#{SPEC_PATH}/fixture/books"
    @tmp_path    = "/tmp/books"
    DataMapper.setup(:gitfs, "gitfs:://#{@tmp_path}?#{@remote_repo}")
  end

  after :each do
    FileUtils.rm_rf @tmp_path
  end
  
end