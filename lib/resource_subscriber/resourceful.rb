module ResourceSubscriber
  module Resourceful
    extend ::ActiveSupport::Concern

    attr_accessor :resource, :changes

    def initialize(*args)
      super(*args)
      @resource = env.payload.instance_variable_get(:@resource)
      @changes = env.payload.instance_variable_get(:changes)
    end

    # def created
    #   binding.pry
    # end

    private
    # def parsed_payload
    #   @parsed_payload ||= ::JSON.parse(payload)
    # end
    #
    # def resource
    #   @resource ||= resource_class.find(payload["id"])
    # end
    #
    # def resource_class
    #   @resource_class ||= ::Trax::Model::Registry.model_type_for_uuid(parsed_payload["id"])
    # end
  end
end
