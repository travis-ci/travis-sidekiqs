module Travis
  module Gatekeeper
    class SentryErrors
      def call(worker, message, queue)
        begin
          yield
        rescue => error
          Metriks.meter('travis.errors').mark
          Raven.captureException(error)
          raise
        end
      end
    end
  end
end
