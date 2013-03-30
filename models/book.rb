class Book

  include DataMapper::Gitfs::Resource
  resource_type :directory
  has n, :chapters, 'Chapter'

  def rename(new_path)
    self.base_path = new_path
    self.save
  end
end