require 'spec_helper'

describe Travis::Sidekiq::SentryErrors do
  class FakeRaven
    attr_reader :events

    def initialize
      @events = []
    end

    def send(event)
      @events << event
    end
  end

  let(:errors) {
    Travis::Sidekiq::SentryErrors.new
  }

  let(:raven) {
    FakeRaven.new
  }

  before do
    errors.raven = raven
  end

  it "should dispatch the error" do
    begin
      errors.call(nil, nil, nil) do
        raise
      end
    rescue
      p $!
    end
    raven.events.should have(1).item
  end

  it "should include the worker and queue" do
    begin
      errors.call("user_sync", nil, "users") do
        raise
      end
    rescue
      p $!
    end
    raven.events.first.extra[:worker].should == "user_sync"
    raven.events.first.extra[:queue].should == "users"
  end
end
