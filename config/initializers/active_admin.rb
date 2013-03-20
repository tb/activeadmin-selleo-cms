ActiveAdmin.application.tap do |config|
  config.register_javascript 'active_admin/base.js'
  config.register_javascript 'ckeditor/init.js'
  config.register_javascript 'activeadmin-selleo-cms/custom.js'
  config.register_javascript 'activeadmin-selleo-cms/jquery-ui-timepicker-addon.js'

  config.register_stylesheet 'activeadmin-selleo-cms/jquery-ui.css'
  config.register_stylesheet 'activeadmin-selleo-cms/custom.css'
  config.register_stylesheet 'activeadmin-selleo-cms/jquery-ui-timepicker-addon.css'

  config.load_paths << "#{ActiveadminSelleoCms::Engine.root}/app/admin"
  config.load_paths <<  File.expand_path('app/admin', Rails.root)

  config.before_filter :set_admin_locale
end

module ActiveAdmin
  class BaseController
    with_role :admin
  end
end
