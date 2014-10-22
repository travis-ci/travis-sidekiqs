require 'sidekiq/worker'
require 'multi_json'

module Travis
  module Sidekiq
    class BuildRequest
      class ProcessingError < StandardError; end

      include ::Sidekiq::Worker

      sidekiq_options queue: :build_requests

      attr_accessor :data

      def perform(data)
        @data = data
        if payload
          service.run
        else
          Travis.logger.warn("The #{type} payload was empty and could not be processed")
        end
      end

      def service
        @service ||= Travis.service(:receive_request, @user, params)
      end

      def params
        { payload: payload, event_type: type, token: credentials['token'], github_guid: github_guid }
      end

      def type
        data['type']
      end

      def credentials
        data['credentials']
      end

      def github_guid
        data['github_guid']
      end

      def payload
        @payload ||= data['payload'] ? MultiJson.decode(data['payload']) : nil
      end
    end
  end
end
