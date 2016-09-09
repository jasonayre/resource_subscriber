require 'spec_helper'

describe ResourceSubscriber do
  it 'has a version number' do
    expect(ResourceSubscriber::VERSION).not_to be nil
  end

  describe '::configuration' do
    subject { ResourceSubscriber.configuration }

    it { expect(subject).to be(ResourceSubscriber.configuration) }
    it { expect(subject.exchange).to be_a(String) }
    it { expect(subject.publishing_options).to be_a(Hash) }
  end

  describe '::configure' do
    let(:exchange) { "NYSE" }
    let(:publishing_options) { { :mandatory => true, :persistent => true } }

    subject { ResourceSubscriber.configuration }

    before do
      ResourceSubscriber.configure do |config|
        config.exchange = exchange
        config.publishing_options = publishing_options
      end
    end

    it { expect(subject.exchange).to be(exchange) }
    it { expect(subject.publishing_options).to be(publishing_options) }
  end
end
