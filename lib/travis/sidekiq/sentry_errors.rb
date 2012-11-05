module Travis
  module Sidekiq
    class SentryErrors
      def call(worker, message, queue)
        begin
          yield
        rescue => error
          dispatch(error, worker, queue)
          raise
        end
      end

      def dispatch(error, worker, queue)
        message = {
          error: error,
          queue: queue,
          worker: worker
        }
        Celluloid::Actor[:sentry_dispatch].async.dispatch(message)
      end
    end
  end
end
