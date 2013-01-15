module ActiveadminSelleoCms
  module ApplicationHelper
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
      if result.is_a? Page
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
  end
end
