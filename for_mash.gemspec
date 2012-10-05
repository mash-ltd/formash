$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "for_mash/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "for_mash"
  s.version     = ForMash::VERSION
  s.authors     = ['AlSayed Gamal', 'Ahmad Sherif']
  s.email       = ['elsayed.gamal@mashsolvents.com', 'ahmad.sherif@mashsolvents.com']
  s.homepage    = 'http://www.mashsolvents.com'
  s.summary     = 'Rails engine that adds interface for creating customizable submittable web forms'
  s.description = "for_mash is a Rails engine that was initially created to be a pluggable mini-app for projects we're working on in mash Ltd."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "dynamic_form", "~> 1.1.4"
  s.add_dependency "nested_form"

  s.add_development_dependency "sqlite3"
end
