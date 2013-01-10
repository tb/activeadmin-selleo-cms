module ActiveadminSelleoCms
  class PagesController < ActiveadminSelleoCms::ApplicationController

    before_filter :find_page

    private

    def find_page
      page_scope = Page.published

      if parent = Page.find_by_slug(params[:page_id])
        page_scope = page_scope.where(parent_id: parent.id)
      end

      unless @page = page_scope.find_by_slug(params[:id])
        redirect_to page_path(I18n.locale, Page.roots.reorder("id ASC").first)
      end
    end

    public

    def show
      @page.increment!(:views)
      render action: :show, layout: @page.layout
    end
  end
end
