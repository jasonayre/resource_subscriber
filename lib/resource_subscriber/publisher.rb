module ResourceSubscriber
  class Publisher
    include ::ResourceSubscriber::AutoInject

    required_dependencies :model, :config

    def resource_base_class_name
      @resource_base_class_name ||= model.base_class.name
    end

    def publish_resource_message(action, resource)
      message = ::ResourceSubscriber::Message.new(
        :resource => resource.attributes,
        :resource_type => resource_base_class_name,
        :changes => resource.previous_changes
      ).to_json

      ::ActionSubscriber::Publisher.publish_async("#{self.config.routing_key}.#{action}", message, self.config.exchange, :content_type => 'application/json')
    end

    def publish_as(routing_key, exchange:'events')
      self.config[:exchange] = exchange
      self.config[:routing_key] = routing_key
    end
  end
end
