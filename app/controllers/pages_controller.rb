class PagesController < CmsController
  before_filter :find_page, only: :show

  private

  def find_page
    page_scope = ActiveadminSelleoCms::Page
    root = ActiveadminSelleoCms::Page.root

    raise "Create at least one page" unless root

    if parent = ActiveadminSelleoCms::Page.find_by_slug(params[:page_id])
      page_scope = page_scope.where(parent_id: parent.id)
    end

    @page = page_scope.find_by_slug(params[:id])

    if !@page or (!@page.is_published? and @page != root)
      redirect_to page_path(I18n.locale, root)
    end
  end

  public

  def show
    @page.update_column(:views, (@page.views || 0) + 1)
    render action: :show, layout: @page.layout_name
  end

  def index
    respond_to do |format|
      format.html { redirect_to page_path(I18n.locale, ActiveadminSelleoCms::Page.root) }
      format.json { render text: ActiveadminSelleoCms::Page.published.map{|p| [p.title, p.url(locale: false)]}.to_json }
    end
  end
end
