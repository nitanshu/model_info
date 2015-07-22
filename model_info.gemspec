$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "model_info/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "model_info"
  s.version     = ModelInfo::VERSION
  s.authors     = ["nitanshu"]
  s.email       = ["nitanshu@headerlabs.com"]

  s.summary     = "Summary of ModelInfo."
  s.description = "Description of ModelInfo."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc", "Gemfile"]

  s.add_dependency 'bootstrap', '0.0.1'
  s.add_dependency 'kaminari', '0.16.3'
  s.add_dependency 'jquery-rails', '4.0.4'
  s.add_development_dependency "sqlite3"
end