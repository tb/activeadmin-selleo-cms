def fill_in_ckeditor(locator, opts)
  browser = page.driver.browser
  content = opts.fetch(:with).to_json
  browser.execute_script <<-SCRIPT
    CKEDITOR.instances['#{locator}'].setData(#{content});
    $('textarea##{locator}').text(#{content});
  SCRIPT
end