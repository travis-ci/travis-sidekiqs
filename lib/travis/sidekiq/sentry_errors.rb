module Travis
  module Sidekiq
    class SentryErrors
      def call(worker, message, queue)
        begin
          yield
        rescue => error
          dispatch(error)
          raise
        end
      end

      def dispatch(error)
        Celluloid::Actor[:sentry_dispatch].async.dispatch(error)
      end
    end
  end
end
