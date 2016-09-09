require 'spec_helper'

describe ResourceSubscriber::Publishable do
  let(:publisher_config) { klass.resource_publisher.config }

  subject(:klass) {
    Class.new {
      def self.after_commit(*args); end
      include ResourceSubscriber::Publishable
    }
  }

  describe '::publish_to' do
    let(:routing_key) { 'route.this.way' }

    it { expect(publisher_config).not_to be(ResourceSubscriber.configuration) }

    context "override global config" do
      let(:exchange_override) { 'override' }
      let(:publishing_options_override) { {:persistent => true } }

      before do
        klass.publish_to(routing_key) do |config|
          config.routing_key = 'should.be.ignored'
          config.exchange = exchange_override
          config.publishing_options = publishing_options_override
        end
      end

      it { expect(publisher_config.routing_key).to eq(routing_key) }
      it { expect(publisher_config.exchange).to eq(exchange_override) }
      it { expect(publisher_config.publishing_options).to eq(publishing_options_override) }
    end
  end
end
