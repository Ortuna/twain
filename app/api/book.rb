Twain::App.controllers :book do

  before do
    remote_path = "#{Padrino.root}/spec/fixture/books" || nil
    local_path  = "/tmp/books"  || nil
    connection_string = "gitfs://#{local_path}"
    connection_string << "?#{remote_path}" if remote_path
    DataMapper.setup(:gitfs, connection_string)
  # rescue
  #   failed_response
  end

  # Gets a list of books that user
  # has access to.
  # /book
  get :index do
    books = Book.all
    json(books)
  end


  private
  def self.json(object)
    MultiJson::dump(object)
  end

  def failed_response(status = 404, response = 'invalid requests')
    halt status, response
  end
end
