def wait_for_dom(timeout = Capybara.default_wait_time)
  uuid = SecureRandom.uuid
  page.find("body")
  page.evaluate_script <<-EOS
    setTimeout(function() {
      $('body').append("<div id='#{uuid}'></div>");
    }, 1000);
  EOS
  page.find("##{uuid}")
end

def wait_for_ajax(timeout = Capybara.default_wait_time)
  page.wait_until(timeout) do
    page.evaluate_script 'jQuery.active == 0'
  end
end

def wait_for_ajax_and_dom(timeout = Capybara.default_wait_time)
  wait_for_ajax(timeout)
  wait_for_dom(timeout)
end