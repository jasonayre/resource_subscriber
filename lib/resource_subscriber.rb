require "resource_subscriber/version"
require 'active_support/all'
require 'action_subscriber'
require 'trax_core'

module ResourceSubscriber
  extend ::ActiveSupport::Autoload

  autoload :AutoInject
  autoload :Changes
  autoload :Message
  autoload :Middlewares
  autoload :Railtie
  autoload :Resourceful
  autoload :Publishable
  autoload :Publisher
  autoload :PublisherConfig

  require "resource_subscriber/railtie" if defined?(Rails)
end
