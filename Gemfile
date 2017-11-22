source 'https://rubygems.org'
ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end


# Base
gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'puma'
gem 'figaro'


# Debugging
gem 'pry-rails'
gem 'pry-byebug'


# Users, authentication, authorization
gem 'bcrypt'
gem 'doorkeeper'
gem 'pundit'


# Validations
gem 'reform'
gem 'reform-rails'


# File upload and processing
# gem 'shrine'
# gem 'shrine-reform'
# gem 'image_processing'
# gem 'mini_magick'


# JSON and utilities
gem 'active_model_serializers'
gem 'kaminari'


# API documentation
gem 'apipie-rails'


group :development do
  # Auto-reloading
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate'
  gem 'rubocop', require: false

  # Optimization
  # gem 'bullet'
  # gem 'derailed_benchmarks'
  # gem 'flamegraph'
  # gem 'rack-mini-profiler'
end


group :test do
  gem 'fuubar'
  gem 'json_expressions', require: false
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'webmock'
end


# group :production do
#   gem 'newrelic_rpm'
# end