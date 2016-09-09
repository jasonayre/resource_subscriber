require "resource_subscriber/version"
require 'active_support/all'
require 'action_subscriber'

module ResourceSubscriber
  extend ::ActiveSupport::Autoload

  autoload :AutoInject
  autoload :Changes
  autoload :Configuration
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

  def self.configuration
    @configuration ||= ::ResourceSubscriber::Configuration.with_defaults
  end

  def self.configure
    yield(self.configuration) if block_given?
  end

  load_railtie if defined?(Rails)
end
