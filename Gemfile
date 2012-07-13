source "http://rubygems.org"

# Declare your gem's dependencies in smartgraphs_connector.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
#


# make sure to match gem versions with the portal
gem "json", "~> 1.6.3"
gem "haml", :git => "git://github.com/concord-consortium/haml.git", :branch => "xml-mime-type-and-ie8-keycode-fix"

group :test, :development do
  gem "rspec",       "~> 2.10.0"
  gem "rspec-rails", "~> 2.10.1"
  gem "ci_reporter", "~> 1.7.0"
  gem "fakeweb",     "~> 1.3.0"
end
