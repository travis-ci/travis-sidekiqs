require 'sidekiq/worker'

module Travis
  module Sidekiq
    class Blackhole
      include Sidekiq::Worker

      def perform(message)
        puts message
        raise
      end
    end
  end
end
