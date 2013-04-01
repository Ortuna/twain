describe Repo do

  before :each do
    Helper.clean_users
    Helper.clean_repos
  end

  it 'creates a repo correctly' do
    location = 'http://www.google.com'
    expect{
      user = Helper.create_user('testuser', 'password')
      Helper.create_repo(user[:id], location)
    }.to_not raise_error

    Repo.first(:location => location).should_not be_nil
  end

  it 'has the correct relationships' do
      user = Helper.create_user('testuser', 'password')
      Helper.create_repo(user[:id], 'http://netscape.com')
      repo = Repo.first(:location => 'http://netscape.com')
      repo.user[:username].should == 'testuser'
  end
end