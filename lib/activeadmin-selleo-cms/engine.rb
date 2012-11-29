module ActiveadminSelleoCms
  class Engine < ::Rails::Engine
    isolate_namespace ActiveadminSelleoCms
  end
end

module ActiveAdmin
  class Application
    include Settings
    setting :load_paths, ["#{ActiveadminSelleoCms::Engine.root}/app/admin", File.expand_path('app/admin', Rails.root)]
  end
end
