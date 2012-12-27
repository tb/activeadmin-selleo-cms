module ActiveadminSelleoCms
  class SearchesController < ActiveadminSelleoCms::ApplicationController
    def show
      @results = Search.current_locale.search_by_content(params[:id]).map(&:searchable).uniq
      render action: :show, layout: 'search'
    end
  end
end
