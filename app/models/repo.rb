class Repo
  include DataMapper::Resource

  property :id,       Serial
  property :location, String
  property :name,     String

  belongs_to :user
end