require 'sidekiq/worker'
require 'multi_json'

module Travis
  module Sidekiq
    class BuildRequest
      class ProcessingError < StandardError; end

      include ::Sidekiq::Worker

      attr_accessor :service, :payload

      def perform(payload)
        @payload = payload
        if authenticated?
          run
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
        @service ||= Travis::Services.service(:requests, :receive, @user, payload: data, event_type: type, token: credentials['token'])
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
