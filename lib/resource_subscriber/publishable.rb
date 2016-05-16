module ResourceSubscriber
  module Publishable
    extend ::ActiveSupport::Concern

    class Config < ActiveSupport::InheritableOptions; end

    included do
      after_commit :publish_created, :on => :create
      after_commit :publish_updated, :on => :update

      self.class_attribute :resource_publisher
      self.resource_publisher = ::ResourceSubscriber::Publisher.new(model: self, config: ::ResourceSubscriber.publisher_config.deep_dup)
    end

    module ClassMethods
      def publish_to(routing_key, exchange:'events')
        self.resource_publisher.config[:exchange] = exchange
        self.resource_publisher.config[:routing_key] = routing_key
      end
    end

    def publish_created
      self.resource_publisher.publish_resource_message('created', self)
    end

    def publish_updated
      self.resource_publisher.publish_resource_message('updated', self)
    end
  end
end
