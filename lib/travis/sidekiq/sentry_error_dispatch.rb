require 'celluloid'

module Travis
  module Sidekiq
    class SentryErrorDispatch
      include Celluloid

      def initialize(options) 
        @options = options
      end

      def dispatch(error)
        Raven.captureException(error)
      end
    end
  end
end
