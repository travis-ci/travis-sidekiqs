require 'sidekiq/worker'
require 'multi_json'

module Travis
  module Sidekiq
    class BuildRequest
      class ProcessingError < StandardError; end

      include ::Sidekiq::Worker

      sidekiq_options queue: :build_requests

      attr_accessor :payload

      def perform(payload)
        @payload = payload
        run
      end

      def run
        if data
          service.run
        else
          Travis.logger.warn("The #{type} payload was empty and could not be processed")
        end
      end

      def service
        @service ||= Travis.service(:receive_request, @user, payload: data, event_type: type)
      end

      def type
        payload['type']
      end

      def data
        @data ||= payload['payload'] ? MultiJson.decode(payload['payload']) : nil
      end
    end
  end
end
