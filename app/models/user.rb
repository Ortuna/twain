require 'bcrypt'
class User
  include DataMapper::Resource

  property :id,       Serial
  property :username, String
  property :password, String

  validates_presence_of   :username, :password
  validates_uniqueness_of :username

  has n, :repos, 'Repo'
  before :save, :encrypt_password


  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end

  def self.authenticate(username, password)
    user = User.first(:username)
    return nil unless user
    bpassword = BCrypt::Password.new(user.password)
    return nil unless bpassword
    return nil unless bpassword == password
    user
  end
end