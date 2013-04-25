require 'sidekiq'

module Travis
  module Sidekiq
    class AutoSyncUser
      include ::Sidekiq::Worker
      sidekiq_options queue: :auto_sync_user

      def perform(user_id)
        Travis.run_service(:github_sync_user, id: user_id)
      rescue Exception
      end
    end
  end
end
