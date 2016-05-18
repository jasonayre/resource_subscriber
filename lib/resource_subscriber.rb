require "resource_subscriber/version"
require 'active_support/all'
require 'action_subscriber'

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

  def self.load_railtie
    ::ResourceSubscriber::Railtie
  end

  load_railtie if defined?(Rails)
end
