source 'https://rubygems.org'

ruby File.read(File.join(File.dirname(__FILE__), ".ruby-version"))[/(\d\.){2}\d/]

gem 'capybara'
gem 'capybara-screenshot'
gem 'chromedriver-helper'
gem 'images_by_url'
gem 'selenium-webdriver'

group :dev, :test do
  gem 'rspec'
  gem 'codeclimate-test-reporter', require: false
  gem 'codecov', require: false
  gem 'coveralls', require: false
  gem 'simplecov', require: false
  gem 'rubocop', require: false
  gem 'guard'
  gem 'guard-rubocop'
  gem 'guard-bundler'
end
