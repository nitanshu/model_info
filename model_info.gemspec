$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'model_info/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'model_info'
  s.version = ModelInfo::VERSION
  s.authors = ['nitanshu verma']
  s.email = ['nitanshu1991@gmail.com']
  s.summary = 'ModelInfo provides the UI interface for the CRUD of all models (including engine\'s) and their associated models.'
  s.description = 'ModelInfo provides the UI interface for the CRUD of all models (including engine\'s) and their associated models.'
  s.license = 'MIT'
  s.homepage = 'https://github.com/nitanshu/model_info'
  s.files = Dir['{app,config,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_runtime_dependency 'bootstrap', '~> 4.1.2'
  s.add_runtime_dependency 'kaminari', '~>1.1.1'
end