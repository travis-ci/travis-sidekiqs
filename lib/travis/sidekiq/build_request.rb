require 'sidekiq/worker'

module Travis
  module Sidekiq
    class BuildRequest
      include ::Sidekiq::Worker

      attr_accessor :service, :payload

      def perform(payload)
        @payload = payload
        run
      end

      def run
        service.run
      end

      def service
        @service ||= Travis::Services::Requests::Receive.new(nil, payload)
      end
    end
  end
end
