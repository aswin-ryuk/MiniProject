# git_source(:github) do |repo_name|
#   repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
#   "https://github.com/#{repo_name}.git"
# end

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.7', '>= 6.1.7.1'
gem 'nio4r', '~> 2.4'
gem 'pg'
# Use oracle as the database for Active Record
#gem 'ruby-oci8'
#gem 'ruby-oci8', '~> 2.2', '>= 2.2.7'
#gem 'activerecord-oracle_enhanced-adapter', '~> 5.2'
#gem 'activerecord-oracle_enhanced-adapter', '~> 1.6', '>= 1.6.7'
#gem 'activerecord-oracle_enhanced-adapter'
#gem 'activerecord', '~> 5.0', '>= 5.2.3'
#gem 'activesupport', '~> 5.2', '>= 5.2.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

########gem 'mini_racer', platforms: :ruby
#gem 'mini_racer', '~> 0.6.2'
#gem 'execjs'

gem 'bootstrap', '~> 4.0'

gem 'simple_form'
gem 'country_select'

gem 'pry'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'
#gem 'jquery-ui-rails', '~> 2.0'
# Turbolinks makes navigating your web application faster. read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'bootstrap-datepicker-rails', '~> 1.8', '>= 1.8.0.1'
gem 'bootstrap4-datetime-picker-rails', '~> 0.3.1'
gem 'momentjs-rails', '~> 2.17.1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'cancancan', '3.0.0'
gem 'devise', '~> 4.4', '>= 4.4.1'
gem 'will_paginate', '~> 3.1', '>= 3.1.7'
gem 'will_paginate-bootstrap'             , '1.0.1'
gem 'httparty', '~> 0.14.0'
gem 'activerecord-session_store'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails', '4.8.0'
  gem 'rails-controller-testing'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  #gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'prawn', '~> 2.4'
gem 'prawn-table', '~> 0.2.2'

gem 'chartkick', '2.2.5'
gem 'highcharts_rails'

gem "matrix", "~> 0.4.2"

gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
