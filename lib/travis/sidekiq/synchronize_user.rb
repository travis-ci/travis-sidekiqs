require 'sidekiq'
require 'travis/model/user'

class SynchronizeUser
  include Sidekiq::Worker

  attr_accessor :service, :user_id

  def perform(user_id)
    @user_id = user_id
    user.sync
  rescue StandardError => e
    @user.update_column(is_syncing: false)
    raise
  end

  def user
    @user ||= User.find(user_id)
  end
end
