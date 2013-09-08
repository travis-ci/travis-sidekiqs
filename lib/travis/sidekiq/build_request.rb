require 'sidekiq/worker'
require 'multi_json'
require 'gh'

module Travis
  module Sidekiq
    class BuildRequest
      class ProcessingError < StandardError; end

      include ::Sidekiq::Worker

      sidekiq_options queue: :build_requests

      attr_accessor :payload

      def perform(payload)
        @payload = payload
        if data
          service.run
        else
          Travis.logger.warn("The #{type} payload was empty and could not be processed")
        end
      end

      def service
        event = GH.load(data)
        if event['action'] == 'closed'
          repo = Travis.service(:find_repo, slug: event['pull_request']['repo']['full_name']
          @service ||= Travis.service(:cancel_build, @user, :repository_id: repo.id, pull_request_number: event['number'])
        else
          @service ||= Travis.service(:receive_request, @user, payload: data, event_type: type, token: credentials['token'])
        end
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
    end
  end
end
