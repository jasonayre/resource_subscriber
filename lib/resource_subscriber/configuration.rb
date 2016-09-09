module ResourceSubscriber
  class Configuration < ::ActiveSupport::OrderedOptions
    def self.with_defaults
      new.tap do |c|
        c.exchange = 'events'
        c.publishing_options = { :content_type => 'application/json' }.freeze
      end
    end
  end
end
