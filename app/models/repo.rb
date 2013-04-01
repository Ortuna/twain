class Repo
  include DataMapper::Resource

  property :id,       Serial
  property :location, String

  belongs_to :user, 'User'
end