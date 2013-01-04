def create_page
  click_link 'Pages'
  click_link 'New Page'
  wait_for_ajax_and_dom
  fill_in "page_translations_attributes_0_title", with: 'Sample page'
  check "page_is_published"
  fill_in_ckeditor "page_sections_attributes_0_translations_attributes_0_body", with: "Some header text"
  fill_in_ckeditor "page_sections_attributes_1_translations_attributes_0_body", with: "Some content text"
  fill_in_ckeditor "page_sections_attributes_2_translations_attributes_0_body", with: "Some footer text"
  click_button 'Create Page'
  page.should have_content('Displaying 1 Page')
end

def create_link_url_page(link_url="http://example.org")
  click_link 'Pages'
  click_link 'New Page'
  wait_for_ajax_and_dom
  check "page_is_link_url"
  wait_for_ajax_and_dom
  page.should_not have_css("page_sections_attributes_0_translations_attributes_0_body")
  page.should_not have_css("page_translations_attributes_0_browser_title")
  page.should_not have_css("page_translations_attributes_0_meta_keywords")
  page.should_not have_css("page_translations_attributes_0_meta_description")
  fill_in "page_translations_attributes_0_title", with: 'Sample page'
  check "page_is_published"
  fill_in "page_link_url", with: link_url
  click_button 'Create Page'
  page.should have_content('Displaying 1 Page')
end

def edit_link_url_page(link_url="http://example.org")
  click_link 'Pages'
  click_link 'Edit'
  wait_for_ajax_and_dom
  page.should_not have_css("page_sections_attributes_0_translations_attributes_0_body")
  page.should_not have_css("page_translations_attributes_0_browser_title")
  page.should_not have_css("page_translations_attributes_0_meta_keywords")
  page.should_not have_css("page_translations_attributes_0_meta_description")
  fill_in "page_link_url", with: link_url
  click_button 'Update Page'
  page.should have_content('Displaying 1 Page')
end

def translate_page(locale)
  click_link 'Pages'
  click_link 'Edit'
  wait_for_ajax_and_dom
  page.should have_css("#lang-#{locale.code}")
  click_link locale.name
  wait_for_ajax_and_dom
  fill_in "page_translations_attributes_1_title", with: 'Sample polish page'
  fill_in_ckeditor "page_sections_attributes_0_translations_attributes_3_body", with: "Some polish header text"
  fill_in_ckeditor "page_sections_attributes_1_translations_attributes_3_body", with: "Some polish content text"
  fill_in_ckeditor "page_sections_attributes_2_translations_attributes_3_body", with: "Some polish footer text"
  click_button 'Update Page'
  page.should have_content('Displaying 1 Page')
end

