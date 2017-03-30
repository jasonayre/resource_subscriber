require 'spec_helper'

describe ResourceSubscriber::Middlewares::Router do
  let(:fake_model) {
    FAKE_MODEL = double(:model)
    FAKE_MODEL
  }

  let(:fake_model_instance) { ::Struct.new(:id, :price).new(1, 10) }
  let(:fake_resource_attributes) { {"id" => 1, "price" => 10} }
  let(:fake_env) {
    {
      "payload" => {
        "resource" => fake_resource_attributes,
        "resource_type" => "FAKE_MODEL"
      },
      "resource" => fake_model_instance,
      "action" => :created,
      "message_id" => 123
    }
  }

  let(:fake_app) {
    app = double(:app)
    allow(app).to receive(:call).and_return(fake_env)
    app
  }

  let(:subscriber) { double(:subscriber) }

  before do
    fake_env.stub(:subscriber).and_return(subscriber)
    fake_env.stub(:message_id).and_return(123)
    fake_env.stub(:action).and_return(:created)
    fake_env.stub(:acknowledge)
  end

  subject { described_class.new(fake_app) }

  context "resource not nil" do
    it {

      expect(fake_env.subscriber).to receive(:run_action_with_filters).with(fake_env, :created)
      subject.call(fake_env)
    }
  end

  context "resource nil" do
    before do
      fake_env["resource"] = nil
    end

    it {
      expect(fake_env.subscriber).to_not receive(:run_action_with_filters)
      expect(fake_env).to receive(:acknowledge)
      subject.call(fake_env)
    }
  end
end
