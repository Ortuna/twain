class Mori::App
  include Mori::Common
  include Mori::Util
  layout :site

  get :books, map: '/books' do
    @repos = current_account.repos
    render :books
  end

  get :chapters, map: '/books/:id/chapters' do
    setup_api(params[:id])
    @book       = api.current_book
    @book_id    = params[:id]
    @book_title = @book.title
    @chapters   = @book.chapters
    render :chapters
  end

  get :sections, map: '/books/:id/chapters/:chapter_path/sections' do
    setup_api(params[:id])
    @book       = api.current_book
    @book_id    = params[:id]
    @chapter    = @book.chapters.first(base_path: params[:chapter_path])
    @sections   = @chapter.sections
    render :sections
  end

  get :book_edit, map: 'books/:id/edit' do
    setup_api(params[:id])
    @book       = api.current_book
    @book_id    = params[:id]
    @title      = @book.title || @book.base_path
    render :book_edit
  end

end