class PagesController < CmsController

  before_filter :find_page

  private

  def find_page
    page_scope = ActiveadminSelleoCms::Page

    if parent = ActiveadminSelleoCms::Page.find_by_slug(params[:page_id])
      page_scope = page_scope.where(parent_id: parent.id)
    end

    if @page = page_scope.find_by_slug(params[:id]) and !@page.is_published? and !@page.eql?(ActiveadminSelleoCms::Page.root)
      redirect_to page_path(I18n.locale, ActiveadminSelleoCms::Page.root)
    end
  end

  public

  def show
    @page.update_column(:views, (@page.views || 0) + 1)
    render action: :show, layout: @page.layout_name
  end
end
