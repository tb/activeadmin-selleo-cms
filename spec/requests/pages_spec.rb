require 'spec_helper'

feature "Page management" do

  scenario "I can create a page", js: true do
    login_admin
    create_page
  end

  scenario "I can access the page with slug", js: true do
    login_admin
    create_page
    visit '/en/sample-page'
    page.should have_content('Some header text')
    page.should have_content('Some content text')
    page.should have_content('Some footer text')
  end

  scenario "I can enter page translations when I enable additional locale", js: true do
    login_admin
    create_page
    enable_popular_locale("pl")
    translate_page(ActiveadminSelleoCms::Locale.pl)
    visit '/pl/sample-page'
    page.should have_content('Some polish header text')
    page.should have_content('Some polish content text')
    page.should have_content('Some polish footer text')
  end

  scenario "I cannot change translations for disabled locales", js: true do
    login_admin
    create_page
    enable_popular_locale("pl")
    translate_page(ActiveadminSelleoCms::Locale.pl)
    disable_locale("pl")
    click_link 'Pages'
    click_link 'Edit'
    page.should_not have_css("#lang-pl")
  end

  scenario "I can create page as link url", js: true do
    login_admin
    create_link_url_page
    page.should have_css('a[href="http://example.org"]')
  end

  scenario "I can update link url page", js: true do
    login_admin
    create_link_url_page
    edit_link_url_page("http://jips.org")
    page.should have_css('a[href="http://jips.org"]')
  end

  scenario "Content with no translations fallbacks to default language", js: true do
    login_admin
    enable_popular_locale("pl")
    create_page
    visit '/en/sample-page'
    page.should have_content "Sample page"
    page.should have_content "Some header text"
    page.should have_content "Some content text"
    page.should have_content "Some footer text"
    visit '/pl/sample-page'
    page.should have_content "Sample page"
    page.should have_content "Some header text"
    page.should have_content "Some content text"
    page.should have_content "Some footer text"
  end

  scenario "I should be redirected to first sub page", js: true do
    login_admin
    parent = FactoryGirl.create(:page, title: "Parent", redirect_to_first_sub_page: true)
    FactoryGirl.create(:page, title: "Child", parent: parent)
    visit '/en/parent'
    page.should have_css "a[href*='child']"
  end

end