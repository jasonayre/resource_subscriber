module ResourceSubscriber
  module Middlewares
    class Resourceful
      def initialize(app)
        @app = app
      end

      def call(env)
        attributes = env["payload"]["resource"]
        model = env["payload"]["resource_type"].constantize

        env["resource"] = if env["action"] == :destroyed
          record = model.instantiate(attributes)
          record.instance_variable_set(:@destroyed, true)
          record
        else
          model.find_by(:id => attributes["id"])
        end

        @app.call(env)
      end
    end
  end
end
