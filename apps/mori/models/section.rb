class Section

  include DataMapper::Gitfs::Resource
  resource_type :markdown
  belongs_to :chapter, 'Chapter'

  property :title, String

  def title
    @title || base_path
  end
end