module ActiveadminSelleoCms
  class PagesController < ActiveadminSelleoCms::ApplicationController
    def show
      if @page = Page.published.find_by_slug(params[:id])
        render action: :show, layout: @page.layout
      elsif params[:id]
        redirect_to "/#{I18n.locale}"
      else
        @page = Page.first
        render action: :show, layout: @page.layout
      end
    end
  end
end
