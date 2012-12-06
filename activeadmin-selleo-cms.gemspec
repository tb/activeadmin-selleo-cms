$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin-selleo-cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin-selleo-cms"
  s.version     = ActiveadminSelleoCms::VERSION
  s.authors     = ["Adrian Ossowski"]
  s.email       = ["aossowski@gmail.com"]
  s.homepage    = "http://www.selleo.com"
  s.summary     = "ActiveAdmin CMS extension"
  s.description = "ActiveAdmin CMS extension"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "jquery-rails"
  s.add_dependency "activeadmin"
  s.add_dependency "globalize3"
  s.add_dependency "ckeditor"
  s.add_dependency "paperclip"
  s.add_dependency "language_list"
  s.add_dependency "haml"

  #s.add_development_dependency "sqlite3"
end
