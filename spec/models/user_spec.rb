describe User do
  before :each do
    Helper.clean_users
  end

  it 'should encrypt user password' do
    Helper.create_user('testuser', 'testpassword')
    User.first.should_not          == nil
    User.first.password.should_not == 'testpassword'
  end

  it 'logs a user in with the right password' do
    Helper.create_user('testuser', 'testpassword')
    User.authenticate('testuser', 'testpassword').should_not be_nil
  end

  it 'rejects a user without the right password' do
    Helper.create_user('testuser', 'testpassword1')
    User.authenticate('testuser', 'zzyyxx').should be_nil
  end

  it 'finds repos associated with a user' do
    user = Helper.create_user('testuser', 'password')
    Helper.create_repo(user[:id], 'http://netscape.com')

    repo = user.find_repos.first
    repo.location.should == 'http://netscape.com'
  end
end