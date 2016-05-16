require 'spec_helper'

describe ResourceSubscriber::Changes do
  let(:fake_changes) {
    {
      "price" => [10, 20]
    }
  }
  subject { described_class.new(fake_changes) }

  context "#was_changed?" do
    it { expect(subject.was_changed?("price")).to be true }
    it { expect(subject.was_changed?("whatever")).to be false }
    it { expect(subject.was_changed?("price", :from => 10)).to be true }
    it { expect(subject.was_changed?("price", :from => 20)).to be false }
    it { expect(subject.was_changed?("price", :to => 20)).to be true }
    it { expect(subject.was_changed?("price", :to => 30)).to be false }
  end
end
