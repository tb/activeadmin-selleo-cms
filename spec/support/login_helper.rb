def login_admin
  visit '/admin'
  within("#session_new") do
    fill_in 'user_email', :with => 'admin@example.com'
    fill_in 'user_password', :with => 'password'
  end
  find('input[type="submit"]').click
end