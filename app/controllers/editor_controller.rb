class Mori::App

  get :editor, map: '/books/:id/chapters/:chapter_path/sections/:section_path/edit' do
    setup_api(params[:id])
    @book    = api.current_book
    @book_id = params[:id]
    @chapter = @book.chapters.first(base_path: params[:chapter_path])
    @section = @chapter.sections.first(base_path: params[:section_path])

    @js_assets  = js_assets
    @hbs_assets = handlebar_assets
    render :editor
  end

  private
  def js_assets(path = nil)
    public_assets '**/*.js'
  end

  def handlebar_assets(path = nil)
    public_assets '**/*.handlebars'
  end

  def public_assets(pattern)
    path ||= Padrino.root('public', 'javascripts', 'app', pattern)
    [].tap do |paths|
      Dir.glob(path).each do |asset| 
        paths << asset.gsub(Padrino.root('public'), '')
      end
    end
  end

end