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

  class << self
    
    def find_book(path_or_title)
      (::Book.all(:base_path => path_or_title) +
      ::Book.all(:title => path_or_title)).first
    end

    def all_books
      ::Book.all
    end

  end 
end