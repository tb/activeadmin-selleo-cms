def link_to_page(page)
  if page.is_link_url
    page.link_url
  else
    "/#{I18n.locale}/#{page.slug}"
  end
end

def set_admin_locale
  I18n.locale = :en
end