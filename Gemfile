source 'http://rubygems.org'

gem 'rails', '3.0.9'

#gem 'sqlite3'
gem 'mysql2', "~> 0.2.5"

gem 'oauth'
gem 'twitter'
gem 'will_paginate'
gem 'annotate', '2.4.0'

gem 'jquery-rails', '>= 1.0.12'
gem "jrails", "~> 0.6.0"

group :development, :test do
  gem "rspec-rails", "~> 2.4"
  gem "cucumber-rails", "~> 1.0.2"
  gem "factory_girl_rails", "~> 1.1"
  gem "faker"
end

group :test do
  if RUBY_VERSION == "1.9.2"
    gem 'simplecov', :require => false
    gem 'test-unit'
  end
  gem "database_cleaner", "0.6.7"
  gem 'spork', '0.9.0.rc9'
  gem "timecop", "0.3.5"
  gem "capybara", "~> 1.0.1"
  gem "cucumber", "~> 1.0.2"
  gem "webrat"
end

group :production do
  gem 'unicorn'
end
