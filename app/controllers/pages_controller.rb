class PagesController < CmsController
  respond_to :html, :json

  before_filter :find_page, only: :show

  private

  def find_page
    page_scope = ActiveadminSelleoCms::Page

    if parent = ActiveadminSelleoCms::Page.find_by_slug(params[:page_id])
      page_scope = page_scope.where(parent_id: parent.id)
    end

    if @page = page_scope.find_by_slug(params[:id]) and !@page.is_published? and !@page.eql?(ActiveadminSelleoCms::Page.root)
      redirect_to page_path(I18n.locale, ActiveadminSelleoCms::Page.root)
    elsif !@page
      redirect_to '/'
    end
  end

  public

  def show
    @page.update_column(:views, (@page.views || 0) + 1)
    render action: :show, layout: @page.layout_name
  end

  def index
    respond_with ActiveadminSelleoCms::Page.published.map{|p| [p.title, p.url(locale: false)]}
  end
end
