require 'spec_helper'

describe Travis::Sidekiq::SentryErrorDispatch do
  class FakeRaven
    attr_reader :errors

    def initialize
      @errors = []
    end

    def send(error)
      @errors << error
    end
  end

  let(:raven) {FakeRaven.new}
  let(:dispatch) {
    Travis::Sidekiq::SentryErrorDispatch.new(env: "test").tap do |dispatch|
      dispatch.raven = raven
    end
  }

  it "should transmit the exception to Sentry" do
    expect {
      dispatch.dispatch(error: StandardError.new)
    }.to change(raven.errors, :size)
  end

  it "should send an event with metadata included" do
    dispatch.dispatch(error: StandardError.new)
    raven.errors.first.extra[:env].should == "test"
  end
end
