require 'middleware/runner'

module ResourceSubscriber
  class MiddlewareRunner < ::Middleware::Runner
    # Override the default middleware runner so we can ensure that the
    # router is the last thing called in the stack.
    #
    def initialize(stack)
      stack << ::ResourceSubscriber::Middlewares::Router

      super(stack)
    end
  end
end
