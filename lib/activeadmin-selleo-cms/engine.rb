module ActiveadminSelleoCms
  class Engine < ::Rails::Engine
    isolate_namespace ActiveadminSelleoCms
    config.to_prepare do
      ApplicationController.helper(PagesHelper)
    end
  end
end
