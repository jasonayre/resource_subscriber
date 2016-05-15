module ResourceSubscriber
  module Publishable
    extend ::ActiveSupport::Concern

    class Config < ActiveSupport::InheritableOptions; end

    included do
      after_commit :publish_created, :on => :create
      after_commit :publish_updated, :on => :update
      # class_attribute :_resource_publisher_config
      # self._resource_publisher_config = ::ResourceSubscriber::Publishable::Config.new
      # publisher_klass = ::Trax::Core::NamedClass.new("#{self.class.name}::Publisher", ResourceSubscriber::Publisher)

      self.class_attribute :resource_publisher
      self.resource_publisher = ::ResourceSubscriber::Publisher.new(model: self, config: ::ResourceSubscriber.publisher_config.deep_dup)
    end

    module ClassMethods
      def publish_to(routing_key, exchange:'events')
        self.resource_publisher.config[:exchange] = exchange
        self.resource_publisher.config[:routing_key] = routing_key
      end

      # def publish_resource_message(action, resource)
      #   message = ::ResourceSubscriber::Message.new(
      #     :resource_attributes => resource.attributes,
      #     :resource_type => base_class.name,
      #     :changes => resource.changes
      #   ).to_json
      #
      #   ::ActionSubscriber::Publisher.publish("#{self._resource_publisher_config.routing_key}.#{action}", message, self.config.)
      # end
    end

    def publish_created
      self.resource_publisher.publish_resource_message('created', self)
      # self.class.publish_resource_message('created', self)
    end

    def publish_updated
      self.resource_publisher.publish_resource_message('updated', self)
    end
  end
end
