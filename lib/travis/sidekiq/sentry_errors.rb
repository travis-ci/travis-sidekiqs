module Travis
  module Sidekiq
    class SentryErrors
      def call(worker, message, queue)
        begin
          yield
        rescue => error
          Raven.captureException(error)
          raise
        end
      end
    end
  end
end
