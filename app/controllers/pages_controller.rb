class PagesController < CmsController
  before_filter :find_page, only: :show

  private

  def find_page
    root = ActiveadminSelleoCms::Page.root

    raise "Create at least one page" unless root

    page_id = nil

    5.downto(1).each do |l|
      if params["slug#{l}"] and page = ActiveadminSelleoCms::Page.where(parent_id: page_id).find_by_slug(params["slug#{l}"])
        page_id = page.id
      end
    end

    @page = ActiveadminSelleoCms::Page.find_by_id(page_id)

    if !@page or (!@page.is_published? and @page != root)
      redirect_to page_path(I18n.locale, root)
    elsif @page.redirect_to_first_sub_page
      redirect_to page_path(I18n.locale, @page.children.first || root)
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
