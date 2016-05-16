module ResourceSubscriber
  class Railtie < ::Rails::Railtie
    ::ActiveSupport.on_load(:action_subscriber_routes) do
      stack :resourceful do
        use ::ResourceSubscriber::Middlewares::HasChanges
        use ::ResourceSubscriber::Middlewares::Resourceful

        ::ActiveSupport.run_load_hooks(:resource_subscriber_resourceful_stack, self) if defined?("Rails")
      end
    end
  end
end
