require 'sidekiq/worker'
require 'multi_json'

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
        if authenticated?
          service.run
        end
      end

      def service
        raise(ProcessingError, "the #{type} payload was empty and could not be processed") unless data
        @service ||= Travis::Services::Requests::Receive.new(@user, payload: data, event_type: type, token: credentials['token'])
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
