class SearchesController < CmsController
  def show
    @results = ActiveadminSelleoCms::Search.current_locale.search_by_content(params[:id]).map(&:searchable).uniq
    render action: :show, layout: 'search'
  end
end
