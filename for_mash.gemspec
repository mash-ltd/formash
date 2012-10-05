$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "for_mash/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "for_mash"
  s.version     = ForMash::VERSION
  s.authors     = ['AlSayed Gamal']
  s.email       = ['elsayed.gamal@mashsolvents.com']
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ForMash."
  s.description = "TODO: Description of ForMash."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "dynamic_form", "~> 1.1.4"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
