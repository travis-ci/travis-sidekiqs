source 'https://rubygems.org'

# Specify your gem's dependencies in travis-sidekiq.gemspec
gemspec

gem 'sprockets', '~> 2.1.2'
gem 'travis-core', github: 'travis-ci/travis-core'
gem 'travis-support', github: 'travis-ci/travis-support'
gem "sentry-raven", github: "getsentry/raven-ruby"

group :test do
  gem 'rspec'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'mocha'
end
