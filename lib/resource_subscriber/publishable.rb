module ResourceSubscriber
  module Publishable
    extend ::ActiveSupport::Concern

    included do
      after_commit :publish_created, :on => :create
      after_commit :publish_updated, :on => :update
      after_commit :publish_destroyed, :on => :destroy

      self.class_attribute :resource_publisher

      configuration = ::ResourceSubscriber.configuration.inheritable_copy
      self.resource_publisher = ::ResourceSubscriber::Publisher.new(model: self, config: configuration)
    end

    module ClassMethods
      def publish_to(routing_key, &block)
        self.resource_publisher.publish_as(routing_key, &block)
      end
    end

    def publish_created
      self.resource_publisher.publish_resource_message('created', self)
    end

    def publish_destroyed
      self.resource_publisher.publish_resource_message('destroyed', self)
    end

    def publish_updated
      self.resource_publisher.publish_resource_message('updated', self)
    end
  end
end
