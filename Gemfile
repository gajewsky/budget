source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 6.1.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search'
gem 'puma', '~> 5.3'
gem 'sass-rails', '~> 6'
gem 'webpacker', '~> 5.4'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.11'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'acts-as-taggable-on'
gem 'bootstrap-sass'
gem 'bootstrap-sass-extras'
gem 'chartkick'
gem 'cocoon'
gem 'devise'
gem 'font-awesome-sass', '4.7.0'
gem 'groupdate'
gem 'haml-rails'
gem 'jquery-rails'
gem 'kaminari'
gem 'smarter_csv'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'simple_form'
gem 'validates_formatting_of'
gem 'therubyracer'
gem 'aws-sdk-s3', require: false
gem 'rollbar'
gem 'faker'
gem 'rails_12factor', group: :production
gem 'selectize-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-adminlte'
  gem 'rails-assets-bootstrap-daterangepicker'
  gem 'rails-assets-bootstrap-tokenfield'
  gem 'rails-assets-highcharts'
  gem 'rails-assets-jquery-ui'
  gem 'rails-assets-moment'
end

group :development, :test do
  gem 'bundle-audit'
  gem 'brakeman'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 5.0.1'
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.6'
  gem 'rack-mini-profiler', '~> 2.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
