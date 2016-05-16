module ResourceSubscriber
  module Middlewares
    class HasChanges
      def initialize(app)
        @app = app
      end

      def call(env)
        env["changes"] = ::ResourceSubscriber::Changes.new(env["payload"]["changes"])
        @app.call(env)
      end
    end
  end
end
