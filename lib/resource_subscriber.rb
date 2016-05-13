require "resource_subscriber/version"
require 'active_support/all'
require 'action_subscriber'

module ResourceSubscriber
  extend ::ActiveSupport::Autoload

  autoload :Middlewares
  autoload :Resourceful
  autoload :Publishable
  autoload :Publisher
end
