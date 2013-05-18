class Mori::App

  get :editor, map: '/books/:id/chapters/:chapter_path/sections/:section_path/edit' do
    setup_api(params[:id])
    @book    = api.current_book
    @book_id = params[:id]
    @chapter = @book.chapters.first(base_path: params[:chapter_path])
    @section = @chapter.sections.first(base_path: params[:section_path])

    render :section
  end
end