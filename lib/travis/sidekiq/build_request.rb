require 'sidekiq'
require 'travis/services/requests/receive'

class BuildRequest
  include Sidekiq::Worker

  attr_accessor :service, :payload

  def perform(payload)
    @payload = payload
    run
  end

  def run
    service.run
  end

  def service
    @service ||= Travis::Core::Services::Requests::Receive.new(nil, payload)
  end
end
