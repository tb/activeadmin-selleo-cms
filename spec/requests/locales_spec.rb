feature "Locale management" do

  scenario "I can enable locale", js: true do
    login_admin
    click_link 'Locales'
    page.should have_content('Displaying 1 Locale')
    enable_popular_locale("pl")
    click_link 'Enabled'
    page.should have_content('Displaying all 2 Locales')
  end

  scenario "I can disable locale", js: true do
    login_admin
    click_link 'Locales'
    page.should have_content('Displaying 1 Locale')
    uncheck 'activeadmin_selleo_cms_locale_enabled_en'
    wait_for_ajax_and_dom
    click_link 'Enabled'
    page.should have_content('No Locales found')
  end

end