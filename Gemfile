source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'
gem 'pg'

gem 'redis-rails'

# https://github.com/NoamB/sorcery
gem "sorcery" #, 

#https://github.com/mislav/will_paginate
gem 'will_paginate', '~> 3.0'

git 'git://github.com/palkan/date_time_attribute.git', :branch => "master" do
  gem 'date_time_attribute'
end

# Assets proccessing
gem "slim-rails"
gem 'sass-rails', '~>4.0.0'
gem 'coffee-rails', '~>4.0.0'
gem 'uglifier', '>= 1.0.3'
gem 'skim'
gem "font-awesome-rails"
gem 'jquery-rails'

# for browser client timezone detect
gem 'detect_timezone_rails'

# for fulltext PostgreSQL search
gem 'textacular', '~> 3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'puma'

group :development, :test do  
  gem "rspec", "~> 2.14.0"
  gem 'rspec-rails', "~> 2.14.0"
  gem "factory_girl_rails", "~> 4.0"
  gem 'capybara'  
  gem 'json_spec'
  gem 'faker'
end

# profiling/debugging
# gem 'rack-mini-profiler'
gem 'pry-byebug', group: [:development, :test]