module ResourceSubscriber
  class Railtie < ::Rails::Railtie
    ::ActiveSupport.on_load(:action_subscriber_routes) do
      stack :resourceful do
        use ::ResourceSubscriber::Middlewares::HasChanges
        use ::ResourceSubscriber::Middlewares::Resourceful
        self.instance_variable_set(:@runner_class, ::ResourceSubscriber::MiddlewareRunner)

        ::ActiveSupport.run_load_hooks(:resource_subscriber_resourceful_stack, self)
        self
      end
    end
  end
end
