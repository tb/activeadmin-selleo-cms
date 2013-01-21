module PagesHelper
  def link_to_locale(link_name, locale, page=nil)
    if page
      link_to link_name, page_path(locale.code, page.translated_attribute(:slug, locale.code))
    elsif request.fullpath.match(/^\/\w{2}\/.*/)
      link_to link_name, request.fullpath.gsub(/^\/(\w{2})\//, "/#{locale.code}/")
    else
      link_to link_name, "/#{locale.code}"
    end
  end

  def link_to_search_result(result)
    if result.is_a? ActiveadminSelleoCms::Page
      link_to result, page_path(I18n.locale, result)
    end
  end

  def url_to_page(page)
    return "#" unless page
    if page.is_link_url
      page.link_url
    elsif page.redirect_to_first_sub_page
      page.children.published.any? ? url_to_page(page.children.published.first) : "#"
    else
      page_path(I18n.locale, page)
    end
  end

  def link_to_page(page, link_name=nil)
    link_to (link_name || page.title), url_to_page(page)
  end

  def s(name)
    section = ActiveadminSelleoCms::Section.where(name: name).first_or_create
    body = section.body.to_s
    body = "" if body.match /<p>\s*<\/p>/
    body += link_to(t("active_admin.cms.edit"), edit_admin_section_path(section)) if current_user and current_user.administrator?
    body.html_safe
  end
end
