module ResourceSubscriber
  class Publisher
    include ::ResourceSubscriber::AutoInject
    # attr_accessor :config
    #
    # def initialize(model:, config:ResourceSubscriber.publisher_config.deep_dup)
    #   @model = model
    #   @config = ::ResourceSubscriber.publisher_config.deep_dup
    # end

    required_dependencies :model, :config

    def resource_base_class_name
      @resource_base_class_name ||= @model.base_class.name
    end

    def publish_resource_message(action, resource)
      message = ::ResourceSubscriber::Message.new(
        :resource_attributes => resource.attributes,
        :resource_type => resource_base_class_name,
        :changeset => resource.changes
      ).to_json

      ::ActionSubscriber::Publisher.publish("#{self.config.routing_key}.#{action}", message, self.config.exchange)
    end

    def publish_as(routing_key, exchange:'events')
      self.config[:exchange] = exchange
      self.config[:routing_key] = routing_key
    end

    # def self.inherited(subklass)
    #   subklass.class_attribute :config
    #   subklass.config = ::ResourceSubscriber.publisher_config.deep_dup
    # end

    def self.publish_resource_message(action, resource)
      message = ::ResourceSubscriber::Message.new(
        :resource_attributes => resource.attributes,
        :resource_type => resource.base_class.name,
        :changes => resource.changes
      ).to_json

      ::ActionSubscriber::Publisher.publish("#{self.config.routing_key}.#{action}", message, self.config.exchange, :content_type => 'application/json')
    end
  end
end
