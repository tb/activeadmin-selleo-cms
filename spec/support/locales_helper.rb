def enable_popular_locale(locale_code)
  click_link 'Locales'
  click_link 'Popular'
  check "activeadmin_selleo_cms_locale_enabled_#{locale_code}"
  wait_for_ajax
end

def disable_locale(locale_code)
  click_link 'Locales'
  uncheck "activeadmin_selleo_cms_locale_enabled_#{locale_code}"
  wait_for_ajax
end