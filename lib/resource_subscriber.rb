require "resource_subscriber/version"
require 'active_support/all'
require 'action_subscriber'
require 'trax_core'

module ResourceSubscriber
  extend ::ActiveSupport::Autoload

  autoload :AutoInject
  autoload :Config
  autoload :Message
  autoload :Middlewares
  autoload :Resourceful
  autoload :Publishable
  autoload :Publisher
  autoload :PublisherConfig

  def self.config
    @_config ||= ::ResourceSubscriber::Config.new
  end

  def self.publisher_config
    @_publisher_config ||= ::ResourceSubscriber::PublisherConfig.new
  end

  def self.configure(&block)
    block.call(config)
  end
end
