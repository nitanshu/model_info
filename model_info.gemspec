$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "model_info/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "model_info"
  s.version     = ModelInfo::VERSION
  s.authors     = ["nitanshu"]
  s.email       = ["nitanshu@headerlabs.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ModelInfo."
  s.description = "TODO: Description of ModelInfo."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "better_errors"

  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'bootstrap'
end
