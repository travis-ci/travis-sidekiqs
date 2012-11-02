require 'sidekiq'
require 'travis/model/user'

module Travis
  module Sidekiq
    class SynchronizeUser
      include ::Sidekiq::Worker

      attr_accessor :user, :repository

      def perform(user_id)
        user(user_id).sync
      rescue StandardError => e
        user(user_id).update_column(:is_syncing, false)
        raise
      end

      def user(user_id)
        @user ||= repository.find(user_id)
      end

      def repository
        @repository ||= ::User
      end
    end
  end
end
