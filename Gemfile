source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
gem 'jquery-rails', '3.0.1'
gem 'mysql2'
#gem 'execjs'
gem 'therubyracer', :platforms => :ruby

# Dev and test gems
group :development, :test do
  gem 'rspec-rails', '2.13.2'
  gem 'guard-rspec', '3.0.2'
  gem 'guard-spork', '1.5.1'
  gem 'spork', '0.9.2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '4.0.0'
  gem 'coffee-rails', '4.0.0'
  gem 'uglifier', '2.1.1'
end

#only test gems
group :test do
  #gem 'capybara', '2.0.2'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'cucumber-rails', '1.3.0', :require => false
  gem 'database_cleaner', '1.0.1'
  gem 'launchy', '2.1.0' # for save_and_open_page
  # gem 'rb-fsevent', '0.9.1', :require => false
  # gem 'growl', '1.0.3'
end

group :production do
  # gem 'pg', '0.12.2'
end