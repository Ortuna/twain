class Book

  include DataMapper::Gitfs::Resource
  resource_type :directory
  has n, :chapters, 'Chapter'

end