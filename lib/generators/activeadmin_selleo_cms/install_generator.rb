module ActiveadminSelleoCms
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc "Installs ActiveAdmin Selleo CMS"

      def self.source_root
        File.expand_path("../templates", __FILE__)
      end

      def setup_routes
        routing_code = "mount ActiveadminSelleoCms::Engine => '/'"
        log :route, routing_code
        sentinel = /ActiveAdmin\.routes.*$/

        in_root do
          inject_into_file 'config/routes.rb', "\n\n  #{routing_code}", { :after => sentinel, :verbose => false }
        end
      end

      def setup_migrations
        rake "activeadmin_selleo_cms:install:migrations"
      end

      def copy_sample_layout
        copy_file "cms.html.erb", "app/views/layouts/cms.html.erb"
      end

    end
  end
end
