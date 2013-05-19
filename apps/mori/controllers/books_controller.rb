class Mori::App
  include Mori::Common
  include Mori::Util
  layout :site

  get :books, map: '/books' do
    @repos = @user.repos
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

end