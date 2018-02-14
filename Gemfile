source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.0'

gem 'pg', '~> 0.21'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'

# Templates, styles, JS
gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'bootstrap_form',
    git: 'https://github.com/bootstrap-ruby/bootstrap_form.git',
    branch: 'master'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails', '~> 3.1', '>= 3.1.3'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.0'

# Pagination
gem 'kaminari'

# Decorators
gem 'draper', '~> 3.0', '>= 3.0.1'

# JSON
gem 'active_model_serializers', '~> 0.10.0'

# Cache
gem 'dalli', '~> 2.7', '>= 2.7.6'
gem 'redis', '~> 3.0'

# User authentication
gem 'devise', '~> 4.4'
gem 'pundit', '~> 1.1'
gem 'rack-cors', require: 'rack/cors'

# Images upload and manipulation
gem 'carrierwave', '~> 1.2'
gem 'mini_magick', '~> 4.8'

# Other
gem 'default_value_for', '~> 3.0', '>= 3.0.2'

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development

# ENV management
gem 'figaro'

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'fuubar', '~> 2.3', '>= 2.3.1'
  gem 'letter_opener'
  gem 'pry'
  gem 'rspec-rails', '~> 3.7'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'html2slim'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'meta_request'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :jruby]
