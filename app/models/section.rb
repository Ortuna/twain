class Section

  include DataMapper::Gitfs::Resource
  resource_type :markdown
  belongs_to :chapter, 'Chapter'

  property :title, String

end