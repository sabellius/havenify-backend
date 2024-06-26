source "https://rubygems.org"

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs
gem 'jsonapi-serializer', '~> 2.2'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Flexible authentication solution for Rails with Warden
gem 'devise', '~> 4.9', '>= 4.9.3'

# JWT authentication for devise with configurable token revocation strategies
gem 'devise-jwt', '~> 0.11.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors', '~> 2.0', '>= 2.0.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]

  # Test framework for Ruby on Rails applications
  gem 'rspec-rails', '~> 6.1', '>= 6.1.1'

  # Fixture replacement with integration to Rails
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'

  # Rspec-compatible one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 6.1'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Fake data generator
  gem 'faker', '~> 3.2', '>= 3.2.3'

  # Pretty print Ruby objects
  gem 'awesome_print', '~> 1.9', '>= 1.9.2'
end

