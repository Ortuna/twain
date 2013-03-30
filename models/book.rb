class Book

  include DataMapper::Gitfs::Resource
  resource_type :directory
  has n, :chapters, 'Chapter'

  property :title, String

  def rename(new_title)
    self.title     = new_title
    self.base_path = new_title.downcase.parameterize
    self.save
  end
end