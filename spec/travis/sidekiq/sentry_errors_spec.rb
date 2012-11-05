require 'spec_helper'

describe Travis::Sidekiq::SentryErrors do
  let(:errors) {
    Travis::Sidekiq::SentryErrors.new
  }

  class FakeSentryErrorDispatch
    include Celluloid
    
    attr_reader :errors

    def initialize()
      @errors = []
    end

    def dispatch(error)
      errors << error
    end
  end

  let(:dispatch) {
    Celluloid::Actor[:sentry_dispatch]
  }

  before do
    FakeSentryErrorDispatch.supervise_as :sentry_dispatch
  end

  it "should dispatch the error" do
    begin
      errors.call(nil, nil, nil) do
        raise
      end
    rescue
    end
    dispatch.errors.should have(1).item
  end
end
