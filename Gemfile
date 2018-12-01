source 'https://rubygems.org'

unless Gem.win_platform?
  ruby File.read(File.join(File.dirname(__FILE__), '.ruby-version'))[/(\d\.){2}\d/]
end

gem 'capybara'
gem 'capybara-mechanize'
gem 'capybara-screenshot'
gem 'chromedriver-helper'
gem 'mechanize'
gem 'selenium-webdriver'
gem 'thor'

group :dev, :test do
  gem 'byebug'
  gem 'codecov', require: false
  gem 'coveralls', require: false
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'rake'
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end
