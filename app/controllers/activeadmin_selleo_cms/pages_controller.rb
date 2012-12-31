module ActiveadminSelleoCms
  class PagesController < ActiveadminSelleoCms::ApplicationController
    def show
      if params[:id] and @page = Page.published.find_by_slug(params[:id])
        render action: :show, layout: @page.layout
      elsif params[:id]
        redirect_to "/#{I18n.locale}"
      else
        @page = Page.roots.reorder("id ASC").first
        render action: :show, layout: @page.layout
      end
      @page.increment!(:views) if @page
    end
  end
end
