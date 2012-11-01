require 'sidekiq/worker'

class Blackhole
  include Sidekiq::Worker

  def perform(message)
    puts message
    raise
  end
end
