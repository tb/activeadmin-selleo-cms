def create_page
  click_link 'Pages'
  click_link 'New Page'
  select 'cms', from: 'page_layout_name'
  check "page_is_published"
  within "#lang-en" do
    find(:css, 'input[id$="_title"]').set('Sample page')
    find(:css, 'input[id$="_slug"]').set('sample-page')
    sections = all(:css, 'textarea[id$="_body"]')
    fill_in_ckeditor sections[0]['id'], with: "Some header text"
    fill_in_ckeditor sections[1]['id'], with: "Some content text"
    fill_in_ckeditor sections[2]['id'], with: "Some footer text"
  end
  click_button 'Create Page'
  page.should have_content('Page was successfully created')
end

def create_link_url_page(link_url="http://example.org")
  click_link 'Pages'
  click_link 'New Page'
  select 'cms', from: 'page_layout_name'
  check "page_is_link_url"
  within "#lang-en" do
    find(:css, 'input[id$="_title"]').set('Sample page')
    find(:css, 'input[id$="_slug"]').set('sample-page')
    find(:css, '[id$="_body"]').should_not be_visible
    find(:css, '[id$="_browser_title"]').should_not be_visible
    find(:css, '[id$="_meta_keywords"]').should_not be_visible
    find(:css, '[id$="_meta_description"]').should_not be_visible
  end
  check "page_is_published"
  fill_in "page_link_url", with: link_url
  click_button 'Create Page'
  page.should have_content('Page was successfully created')
end

def edit_link_url_page(link_url="http://example.org")
  click_link 'Pages'
  click_link 'Edit'
  within "#lang-en" do
    find(:css, '[id$="_body"]').should_not be_visible
    find(:css, '[id$="_browser_title"]').should_not be_visible
    find(:css, '[id$="_meta_keywords"]').should_not be_visible
    find(:css, '[id$="_meta_description"]').should_not be_visible
  end
  fill_in "page_link_url", with: link_url
  click_button 'Update Page'
  page.should have_content('Page was successfully updated')
end

def translate_page(locale)
  click_link 'Pages'
  click_link 'Edit'
  page.should have_css("#lang-#{locale.code}")
  click_link locale.name
  within "#lang-pl" do
    find(:css, 'input[id$="_title"]').set('Sample polish page')
    find(:css, 'input[id$="_slug"]').set('sample-polish-page')
    sections = all(:css, 'textarea[id$="_body"]')
    fill_in_ckeditor sections[0]['id'], with: "Some polish header text"
    fill_in_ckeditor sections[1]['id'], with: "Some polish content text"
    fill_in_ckeditor sections[2]['id'], with: "Some polish footer text"
  end
  click_button 'Update Page'
  page.should have_content('Page was successfully updated')
end

