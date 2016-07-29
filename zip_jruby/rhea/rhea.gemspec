$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rhea/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rhea"
  s.version     = Rhea::VERSION
  s.authors     = ["Prasath Venkatraman"]
  s.email       = ["ask4prasath@gmail.com"]
  s.homepage    = "http://www.zyudlylabs.com"
  s.summary     = "RHEA Rails API"
  s.description = "Data Lake Management API"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency "aasm"

  s.add_development_dependency "sqlite3"
end
