module ResourceSubscriber
  module Middlewares
    extend ::ActiveSupport::Autoload

    autoload :HasChanges
    autoload :Resourceful
    autoload :Router
  end
end
