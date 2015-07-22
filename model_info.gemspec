$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "model_info/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "model_info"
  s.version     = ModelInfo::VERSION
  s.authors     = ["nitanshu verma"]
  s.email       = ["nitanshu1991@gmail.com"]

  s.summary     = "ModelInfo provides the CRUD of all models and their associated models"
  s.description = "ModelInfo gem build on a thought where you should not write a single line of code and you get every models CRUD easily."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'bootstrap', '0.0.1'
  s.add_dependency 'kaminari', '0.16.3'
  s.add_development_dependency "sqlite3"
end