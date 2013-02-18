module PagesHelper
  def link_to_locale(link_name, locale, page=nil)
    if page
      link_to link_name, url_to_page(page, locale.to_s)
    elsif request.fullpath.match(/^\/\w{2}\/.*/)
      link_to link_name, request.fullpath.gsub(/^\/(\w{2})\//, "/#{locale.code}/")
    else
      link_to link_name, "/#{locale.code}"
    end
  end

  def link_to_search_result(result)
    if result.is_a? ActiveadminSelleoCms::Page
      "#{link_to result.breadcrumb, result.url} #{link_to "(e)", edit_admin_page_path(result.id), target: '_blank' if current_user}".html_safe
    end
  end

  def url_to_page(page, locale=I18n.locale)
    return "#" unless page
    _locale = I18n.locale
    I18n.locale = locale
    _url = page.url
    I18n.locale = _locale
    return _url
  end

  def link_to_page(page, link_name=nil, options={})
    link_to (link_name || page.title), page.url, options
  end

  def s(name)
    section = ActiveadminSelleoCms::Section.where(name: name).first_or_create
    body = section.body.to_s
    body = "" if body.match /<p>\s*<\/p>/
    body += link_to(t("active_admin.cms.edit"), edit_admin_section_path(section)) if current_user and current_user.respond_to? :admin? and current_user.admin?
    body.html_safe
  end

  def menu(options={})
    options[:ul] ||= {}
    options[:li] ||= {}

    content_tag :ul, class: options[:ul][:class] do
      ActiveadminSelleoCms::Page.published.show_in_menu.where(parent_id: options[:root]).reorder("lft ASC").collect{ |page|
        classes = [options[:li][:class], options[:li][:selected]].compact.join(" ") if page == @page
        if block_given?
          concat(content_tag :li, yield(page), class: classes)
        else
          concat(content_tag :li, link_to_page(page), class: classes)
        end
      }
    end
  end

  def locales(options={}, &block)
    options[:ul] ||= {}
    options[:li] ||= {}
    locales_scope = ActiveadminSelleoCms::Locale.enabled
    locales_scope = locales_scope.exclude(I18n.locale) unless options[:current_locale]

    content_tag :ul, class: options[:ul][:class] do
      locales_scope.collect{ |locale|
        classes = [options[:li][:class], options[:li][:selected]].compact.join(" ") if locale == I18n.locale
        if block_given?
          concat(content_tag :li, yield(locale), class: classes)
        else
          concat(content_tag :li, link_to_locale(locale.code.to_s.upcase, locale, @page), class: classes)
        end
      }
    end
  end

  def root
    page_path(I18n.locale, ActiveadminSelleoCms::Page.root)
  end
end
