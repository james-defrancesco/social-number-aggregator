source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'


# Front end
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'autoprefixer-rails'
gem 'jbuilder'
gem "bulma-rails"
gem "font-awesome-rails"


# social
gem 'twitter', '~> 6.1'
gem "koala"
gem 'insta_scraper'
gem 'yt', '~> 0.28.0'


# Back end
gem 'pg', '~> 0.19'
gem 'devise', '~> 4.2'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'httparty', '~> 0.15.6'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara', '~> 2.6', '>= 2.6.2'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'guard-rspec', require: false
end

group :development do
  gem 'puma'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
