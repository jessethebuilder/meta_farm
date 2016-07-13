$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "meta_farm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "meta_farm"
  s.version     = MetaFarm::VERSION
  s.authors     = ["Jesse Farmer"]
  s.email       = ["jesse@anysoft.us"]
  s.homepage    = "http://anysoft.us"
  s.summary     = "A simple class to manage website meta information"
  s.description = "Check"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
  
  s.test_files = Dir["spec/**/*"]
end
