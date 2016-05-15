module ResourceSubscriber
  class Message < ::Trax::Core::Types::Struct
    string :resource_type
    string :content_type, :default => "application/json"
    json :resource_attributes
    json :changeset
  end
end
