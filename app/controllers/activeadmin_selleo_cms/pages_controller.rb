module ActiveadminSelleoCms
  class PagesController < ActiveadminSelleoCms::ApplicationController
    def show
      @page = Page.find_by_slug(params[:slug])
      render action: :show, layout: false
    end
  end
end
