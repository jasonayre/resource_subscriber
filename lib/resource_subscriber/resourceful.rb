module ResourceSubscriber
  module Resourceful
    extend ::ActiveSupport::Concern

    def created
      binding.pry
    end

    private
    def parsed_payload
      @parsed_payload ||= ::JSON.parse(payload)
    end

    def resource
      @resource ||= resource_class.find(payload["id"])
    end

    def resource_class
      @resource_class ||= ::Trax::Model::Registry.model_type_for_uuid(parsed_payload["id"])
    end
  end
end
