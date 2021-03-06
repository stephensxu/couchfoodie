source 'https://rubygems.org'
ruby "2.1.2"

gem 'rails', '4.1.4'
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use BCrypt for has_secure_password
# See: http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
gem 'bcrypt', '~> 3.1.7'
gem 'valid_email'
# using psql both locally and production
gem 'pg'
gem 'simple_form'
gem 'annotate', '~> 2.6.5'
gem 'validates_timeliness'
gem 'sass-rails', '~> 4.0.3'

gem 'omniauth-facebook'
gem 'omniauth'

gem 'carrierwave'
gem 'mini_magick'
gem 'carrierwave-aws'

gem 'addressable', :require => 'addressable/uri'

gem 'sidekiq'
gem 'carrierwave_backgrounder'

gem 'slim', '>= 1.1.0'
gem 'sinatra', '>=1.3.0', :require => nil

gem 'redis'

gem 'thin'

gem 'newrelic_rpm'

gem 'mandrill-api'


group :development do
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Mutes console log entries for CSS, JavaScript, and other assets.
  # See: https://github.com/evrone/quiet_assets
  gem 'quiet_assets'
end

group :test, :development do

  # Use dotenv with Rails
  # See: https://github.com/bkeepers/dotenv
  gem 'dotenv-rails'

  # RSpec for Rails
  # See: https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.0.0'
end

group :test do
  # Useful for generating database entries for testing
  # See: https://github.com/thoughtbot/factory_girl_rails
  gem 'factory_girl_rails', '~> 4.0'

  # Useful for generating dummy data, e.g., fake email addresses
  # See: https://github.com/stympy/faker
  gem 'faker'

  # Useful Rails-specific RSpec matchers
  # See: https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers'
  gem 'timecop'
end

# Gems we need on Heroku but not locally
group :production do
  gem 'rails_12factor'
end
