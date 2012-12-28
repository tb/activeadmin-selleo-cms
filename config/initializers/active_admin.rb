ActiveAdmin.setup do |config|
  config.register_javascript 'ckeditor/init.js'
  config.register_javascript 'activeadmin-selleo-cms/custom.js'

  config.register_stylesheet 'activeadmin-selleo-cms/jquery-ui.css'
  config.register_stylesheet 'activeadmin-selleo-cms/custom.css'
end
