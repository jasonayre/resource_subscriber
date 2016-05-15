module ResourceSubscriber
  module Middlewares
    class Resourceful
      def initialize(app)
        @app = app
      end

      def call(env)
        parsed_payload = parse_payload(env.payload)
        resource_attributes = parsed_payload["resource_attributes"]
        resource_class = parsed_payload["resource_type"].constantize
        resource = resource_class.find(resource_attributes["id"])
        env.instance_variable_set(:@resource, resource)
        @app.call(env)
      end

      def parse_payload(payload)
        ::JSON.parse(payload)
      end

      def resource_class_for_payload(parsed_payload)
        ::Trax::Model::Registry.model_type_for_uuid(parsed_payload["id"])
      end
    end
  end
end
