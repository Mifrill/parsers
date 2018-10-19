source 'https://rubygems.org'

ruby File.read(File.join(File.dirname(__FILE__), '.ruby-version'))[/(\d\.){2}\d/]

gem 'capybara'
gem 'capybara-screenshot'
gem 'chromedriver-helper'
gem 'images_by_url'
gem 'rest-client'
gem 'selenium-webdriver'

group :dev, :test do
  gem 'codecov', require: false
  gem 'coveralls', require: false
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rubocop'
  gem 'rake'
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'simplecov', require: false
end
