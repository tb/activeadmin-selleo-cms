ActiveAdmin.setup do |config|
  config.register_javascript 'ckeditor/init.js'
  config.register_javascript 'activeadmin-selleo-cms/custom.js'

  config.register_stylesheet 'activeadmin-selleo-cms/jquery-ui.css'
  config.register_stylesheet 'activeadmin-selleo-cms/custom.css'

  config.load_paths << "#{ActiveadminSelleoCms::Engine.root}/app/admin"
  config.load_paths <<  File.expand_path('app/admin', Rails.root)
end
