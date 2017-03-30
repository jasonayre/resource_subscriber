require 'spec_helper'

describe ResourceSubscriber::Middlewares::Resourceful do
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
      }
    }
  }

  let(:fake_app) {
    app = double(:app)
    allow(app).to receive(:call).and_return(fake_env)
    app
  }

  subject { described_class.new(fake_app) }

  context "resource can be found and not destroy action" do
    before do
      allow(fake_model).to receive(:find_by).and_return(fake_model_instance)
    end

    it { expect(subject.call(fake_env)["resource"]).to eq fake_model_instance }
  end

  context "resource was destroyed" do
    before do
      fake_env.merge!("action" => :destroyed)
      allow(fake_model).to receive(:instantiate).with(fake_resource_attributes).and_return(fake_model_instance)
    end

    it {
      expect(fake_model_instance).to receive(:freeze)
      expect(subject.call(fake_env)["resource"]).to eq fake_model_instance
    }
  end
end
