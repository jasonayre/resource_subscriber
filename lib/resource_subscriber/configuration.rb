require "active_support/ordered_options"

module ResourceSubscriber
  class Configuration < ::ActiveSupport::InheritableOptions
    def self.with_defaults
      new(
        :exchange => 'events',
        :publishing_options => { :content_type => 'application/json' }
      )
    end
  end
end
