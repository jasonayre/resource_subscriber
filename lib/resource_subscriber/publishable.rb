module ResourceSubscriber
  module Publishable
    extend ::ActiveSupport::Concern

    class Config < ActiveSupport::InheritableOptions; end

    included do
      after_commit :publish_created, :on => :create
      class_attribute :_resource_publisher_config
      self._resource_publisher_config = ::ResourceSubscriber::Publishable::Config.new
    end

    module ClassMethods
      def publish_to(routing_key)
        self._resource_publisher_config[:routing_key] = routing_key
      end
    end

    def publish_created
      ::ActionSubscriber::Publisher.publish("#{self.class._resource_publisher_config.routing_key}.created", self.attributes.to_json, "events")
    end

    def publish_updated
      ::ActionSubscriber::Publisher.publish("#{self.class._resource_publisher_config.routing_key}.updated", self.attributes.to_json, "events")
    end

    # def publishes_actions
    #
    # end
  end
end
