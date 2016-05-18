module ResourceSubscriber
  class Publisher
    include ::ResourceSubscriber::AutoInject

    required_dependencies :model, :config

    def publish_resource_message(action, resource)
      message = ::ResourceSubscriber::Message.new(resource)
      ::ActionSubscriber::Publisher.publish_async("#{self.config.routing_key}.#{action}", message.to_json, self.config.exchange, :content_type => 'application/json')
    end

    def publish_as(routing_key, exchange:'events')
      self.config[:exchange] = exchange
      self.config[:routing_key] = routing_key
    end
  end
end
