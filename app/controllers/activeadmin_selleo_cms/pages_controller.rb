module ActiveadminSelleoCms
  class PagesController < ActiveadminSelleoCms::ApplicationController
    def show
      @page = Page.find_by_slug(params[:slug]) || Page.first
      render action: :show, layout: @page.layout
    end
  end
end
