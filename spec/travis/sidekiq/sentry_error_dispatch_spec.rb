require 'spec_helper'

describe Travis::Sidekiq::SentryErrorDispatch do
  let(:dispatch) {
    Travis::Sidekiq::SentryErrorDispatch.new({}) 
  }

  it "should transmit the exception to Sentry" do
    Raven.expects(:captureException)
    dispatch.dispatch(StandardError.new)
  end
end
