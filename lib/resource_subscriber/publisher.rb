module ResourceSubscriber
  class Publisher
    include ::ResourceSubscriber::AutoInject

    required_dependencies :model, :config

    def publish_resource_message(action, resource)
      message = ::ResourceSubscriber::Message.new(resource)
      ::ActionSubscriber::Publisher.publish_async("#{self.config.routing_key}.#{action}", message.to_json, self.config.exchange, self.config.publishing_options)
    end

    def publish_as(routing_key)
      yield(self.config) if block_given?
      self.config.routing_key = routing_key
    end
  end
end
