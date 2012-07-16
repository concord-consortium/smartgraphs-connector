$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "smartgraphs_connector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "smartgraphs_connector"
  s.version     = SmartgraphsConnector::VERSION
  s.authors     = ["Aaron Unger"]
  s.email       = ["aunger@concord.org"]
  s.homepage    = "http://www.concord.org/"
  s.summary     = "An interface between the CC Portal and the CC Smartgraphs runtime and CC Smartgraphs authoring."
  s.description = "Provides and endpoint for saving and loading learner data in the CC Smartgraphs runtime. Also provides management tools for updating/deploying authored activities."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"

  # make sure to match gem versions with the portal
  s.add_dependency "haml", "~> 3.1.4"
  s.add_dependency "json", "~> 1.6.3"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec",       "~> 2.10.0"
  s.add_development_dependency "rspec-rails", "~> 2.10.1"
  s.add_development_dependency "ci_reporter", "~> 1.7.0"
  s.add_development_dependency "fakeweb",     "~> 1.3.0"
end
