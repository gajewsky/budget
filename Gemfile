# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"
gem "bootsnap", require: false
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.0"
gem "redis", "~> 4.0"
gem "sassc-rails", "~> 2.1"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "image_processing", "~> 1.2"

gem 'acts-as-taggable-on'
gem 'aws-sdk-s3', require: false
gem "brakeman"
gem "bundler-audit"
gem 'devise'
gem 'faker'
gem 'groupdate'
gem 'haml-rails'
gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'kaminari'
gem "net-imap"
gem "net-pop"
gem "net-smtp"
gem 'pg_search'
gem 'rails_12factor', group: :production
gem 'rollbar'
gem "rubocop-rails"
gem 'simple_form'
gem 'smarter_csv'
gem 'validates_formatting_of'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-rails'
  gem "rspec-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "rack-mini-profiler"
  gem "web-console"
end
