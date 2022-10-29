# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.4', '>= 6.1.4.4'

gem 'puma', '~> 5.0'

gem 'sass-rails', '>= 6'

gem 'webpacker', '~> 5.0'

gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.7'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'slim_lint'
  gem 'sqlite3', '~> 1.4'
  gem 'webmock', '~> 3.18.1'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'minitest-power_assert'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end

gem 'aasm', '~> 5.4.0'

gem 'dry-container'

gem 'pundit', '~> 2.2.0'

gem 'enumerize'

gem 'octokit', '~> 5.0'

gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'

gem 'omniauth-rails_csrf_protection'

gem 'rails-i18n'

gem 'rollbar'

gem 'rubocop'

gem 'rubocop-performance'

gem 'rubocop-rails', require: false

gem 'simple_form'

gem 'slim-rails'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
