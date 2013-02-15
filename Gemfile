source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'pg', '~> 0.14.1'
gem 'puma', '~> 1.6.0'
gem 'haml'

gem 'bcrypt-ruby', '~> 3.0.0'
gem 'capistrano'
gem 'capistrano-maintenance'

gem 'pg_search'

gem 'sidekiq', '~> 2.7.0'
gem 'sidekiq-unique-jobs', '~> 2.3.0'

gem 'recommendable', :github => 'davidcelis/recommendable'

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
  gem 'font-awesome-rails'
  gem 'therubyracer', github: 'cowboyd/therubyracer'
  gem 'sass-rails'
  gem 'less-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'pry-suite'
  gem 'quiet_assets'
end

group :test do
  gem 'rspec-rails'
  gem 'minifacture'
end
