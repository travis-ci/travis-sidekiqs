require "travis/sidekiq/workers"
require "travis/sidekiq/sentry_errors" if Travis.config.sentry.dns
