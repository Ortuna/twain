class Chapter

  include DataMapper::Gitfs::Resource

  property :title, String

  resource_type :directory
  belongs_to :book, 'Book'
  has n, :sections, 'Section'

  def title
    @title || base_path
  end
end