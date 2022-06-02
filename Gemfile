source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 6.0.5"
gem "rails-i18n"
gem "config"
gem "bootstrap-sass", "3.4.1"
# Use mysql as the database for Active Record
gem "mysql2", ">= 0.4.4"

gem "puma", "~> 5.0"

gem "bcrypt", "3.1.13"

gem "sass-rails", ">= 6"

gem "webpacker", "~> 5.0"

gem "turbolinks", "~> 5"

gem "jbuilder", "~> 2.7"

gem "faker"

gem "pagy"

gem "figaro"
gem "bootsnap", ">= 1.4.4", require: false


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "pry", "~> 0.14.0"
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
