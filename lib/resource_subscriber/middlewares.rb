module ResourceSubscriber
  module Middlewares
    extend ::ActiveSupport::Autoload

    autoload :HasChanges
    autoload :Resourceful
  end
end
