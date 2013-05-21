class User
  include DataMapper::Resource

  property :id,       Serial
  property :uid,      String
  property :role,     String
  property :provider, String
  property :name,     String
  property :image_url,String

  has n, :repos

  validates_presence_of   :uid, :provider, :name
  validates_uniqueness_of :uid

  def self.find_by_id(id)
    first(:id => id)
  end

  def self.find_by_provider_and_uid(provider, uid)
    first(:provider => provider, 
          :uid => uid)
  end

  def self.create_with_omniauth(auth)
    user       = User.new
    user.attributes = {
      provider:  auth['provider'],
      uid:       auth['uid'],
      name:      auth['info']['name'],
      image_url: auth['info']['image'],
      role:      'author'
    }
    user.save ? user : nil
  end
end