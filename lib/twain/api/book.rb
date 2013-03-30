module Twain
  module Book
    
    def all_books
      ::Book.all
    end

    def find_book(base_path)
      ::Book.first(:base_path => base_path)
    end

    def rename(book, new_name)
      book.rename new_name
    end

  end
end