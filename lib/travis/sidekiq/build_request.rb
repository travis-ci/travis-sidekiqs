require 'sidekiq/worker'
require 'multi_json'

module Travis
  module Sidekiq
    class BuildRequest
      class ProcessingError < StandardError; end

      include ::Sidekiq::Worker

      attr_accessor :payload

      def perform(payload)
        @payload = payload
        if authenticated?
          run
        else
          Travis.logger.warn("Received unauthenticated requests to build #{data["repository"].inspect} for credentials #{credentials.inspect}")
        end
      end

      def run
        if data
          service.run
        else
          Travis.logger.warn("The #{type} payload was empty and could not be processed")
        end
      end

      def service
        @service ||= Travis.service(:receive_request, @user, payload: data, event_type: type, token: credentials['token'])
      end

      def type
        payload['type']
      end

      def credentials
        payload['credentials']
      end

      def data
        @data ||= payload['payload'] ? MultiJson.decode(payload['payload']) : nil
      end

      def authenticate
        @user = User.authenticate_by(credentials)
      end

      def authenticated?
        !!authenticate
      end
    end
  end
end
