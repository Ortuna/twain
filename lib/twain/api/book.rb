module Twain
  module Book
    
    def all_books
      ::Book.all
    end

    def find_book(path_or_title)
      (::Book.all(:base_path => path_or_title) +
      ::Book.all(:title     => path_or_title)).first
    end

    def rename(book, new_name)
      book.rename new_name
    end

  end
end