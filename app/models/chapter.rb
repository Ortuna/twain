class Chapter

  include DataMapper::Gitfs::Resource
  resource_type :directory
  belongs_to :book, 'Book'
  has n, :sections, 'Section'

end