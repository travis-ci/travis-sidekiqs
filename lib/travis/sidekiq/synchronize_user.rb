require 'sidekiq'

module Travis
  module Sidekiq
    class SynchronizeUser
      include ::Sidekiq::Worker
      sidekiq_options retry: 5, queue: :user_sync

      def perform(user_id)
        Travis.run_service(:github_sync_user, id: user_id, force: true)
      end
    end
  end
end
