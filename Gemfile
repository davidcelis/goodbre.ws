source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'pg', '~> 0.14.1'
gem 'puma', '~> 1.6.0'
gem 'haml'
gem 'recommendable', :github => 'davidcelis/recommendable'

gem 'bcrypt-ruby', '~> 3.0.0'
gem 'rails_admin'
gem 'capistrano'
gem 'capistrano-maintenance'

# Required for thinking-sphinx, even when using PostgreSQL
gem 'mysql2', '0.3.12b4'
gem 'thinking-sphinx', '~> 3.0.0'

gem 'sidekiq', '~> 2.7.0'
gem 'sidekiq-unique-jobs', '~> 2.3.0'

# For the sidekiq web interface
gem 'sinatra', :require => nil
gem 'slim', '<= 1.3.0'

gem 'gravatar_image_tag'
gem 'kaminari', '~> 0.14.0'

gem 'newrelic_rpm'
gem 'newrelic-redis'

gem 'twitter-bootstrap-rails', '~> 2.2.0'
gem 'google-analytics-rails'
gem 'jquery-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'font-awesome-sass-rails'
  gem 'libv8', '~> 3.11.8'
  gem 'therubyracer'
  gem 'sass-rails'
  gem 'less-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'minitest-rails'
  gem 'minitest-rails-capybara'
  gem 'miniskirt'
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'quiet_assets'
end
