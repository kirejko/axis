source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.0'

gem 'pg', '~> 0.21'
gem 'rails', '~> 5.1.4'

# Templates, styles, JS
gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails', '~> 4.3'
gem 'font-awesome-rails'
gem 'bootstrap_form',
    git: 'https://github.com/bootstrap-ruby/bootstrap_form.git',
    branch: 'master'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails', '~> 3.1'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.0'

# Pagination
gem 'kaminari', '~> 1.1'

# Decorators
gem 'draper', '~> 3.0'

# JSON
# https://github.com/ohler55/oj
gem 'active_model_serializers', '~> 0.10.0'
gem 'oj', '~> 3.4'

# Cache
gem 'dalli', '~> 2.7', '>= 2.7.6'
gem 'redis', '~> 3.0'

# Background delayed and cron jobs.
# https://github.com/mperham/sidekiq
# https://github.com/javan/whenever
gem 'sidekiq', '~> 5.1'
gem 'whenever', '~> 0.10.0', require: false

# Better logging. https://github.com/roidrage/lograge
gem 'lograge', '~> 0.9.0'

# User authentication
gem 'devise', '~> 4.4'
gem 'pundit', '~> 1.1'
gem 'rack-cors', require: 'rack/cors'

# Images upload and manipulation
gem 'carrierwave', '~> 1.2'
gem 'mini_magick', '~> 4.8'

# Other
gem 'default_value_for', '~> 3.0', '>= 3.0.5'

# ENV management
gem 'figaro', '~> 1.1'

group :development, :test do
  gem 'database_cleaner', '~> 1.6'
  gem 'factory_bot_rails', '~> 4.8'
  gem 'faker', '~> 1.8'
  gem 'fuubar', '~> 2.3'
  gem 'letter_opener', '~> 1.6'
  gem 'pry', '~> 0.11.3'
  gem 'puma', '~> 3.7'
  gem 'rspec-rails', '~> 3.7'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'capybara', '~> 2.18'
  gem 'selenium-webdriver', '~> 3.9'
end

group :development do
  gem 'better_errors', '~> 2.4'
  gem 'binding_of_caller', '~> 0.8.0'
  gem 'html2slim', '~> 0.2.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'meta_request', '~> 0.5.0'
  gem 'rubocop', '~> 0.52.1'
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  # Capistrano
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :jruby]
