module ResourceSubscriber
  module Middlewares
    class Resourceful
      def initialize(app)
        @app = app
      end

      def call(env)
        attributes = env["payload"]["resource"]
        model = env["payload"]["resource_type"].constantize
        env["resource"] = model.find_by(:id => attributes["id"])
        @app.call(env)
      end
    end
  end
end
