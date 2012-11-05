require 'celluloid'
require 'raven'

module Travis
  module Sidekiq
    class SentryErrorDispatch
      include Celluloid

      attr_writer :raven
      attr_reader :options

      def initialize(options = {}) 
        @options = options
      end

      def dispatch(error)
        event = Raven::Event.capture_exception(error.delete(:error)) do |event|
          event.extra = error.merge(env: options[:env])
        end
        raven.send(event)
      end

      def raven
        @raven ||= Raven
      end
    end
  end
end
