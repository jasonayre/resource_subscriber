module ResourceSubscriber
  class Configuration < ::ActiveSupport::OrderedOptions
    def self.with_defaults
      new({
        :exchange => 'events',
        :publishing_options => { :content_type => 'application/json' }.freeze
      }.freeze)
    end
  end
end
