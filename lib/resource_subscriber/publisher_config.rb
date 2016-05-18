module ResourceSubscriber
  class PublisherConfig < ::ActiveSupport::InheritableOptions
    def initialize(*args)
      super(*args)

      self[:exchange] = "events"
    end
  end
end
