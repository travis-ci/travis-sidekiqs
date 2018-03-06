source 'https://rubygems.org'

ruby '2.3.6'

# Specify your gem's dependencies in travis-sidekiq.gemspec
gemspec

gem "sentry-raven", github: "getsentry/raven-ruby"
gem 'multi_json'

group :test do
  gem 'rspec'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'mocha'
end
