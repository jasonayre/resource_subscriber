module ResourceSubscriber
  class Message
    include ActiveModel::Serializers::JSON

    attr_accessor :resource_type, :resource, :changes, :params

    def initialize(resource, params={})
      @resource_type = resource.class.base_class.name
      @changes = resource.changes.blank? ? resource.previous_changes : resource.changes
      @resource = resource.attributes
      @params = params
    end

    def attributes=(hash)
      hash.each do |key, value|
        send("#{key}=", value)
      end
    end

    def attributes
      instance_values
    end
  end
end
