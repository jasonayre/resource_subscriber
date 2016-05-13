module ResourceSubscriber
  class Message < ::Trax::Core::Types::Struct
    string :resource_class
    string :content_type, :default => "application/json"
    json :resource_attributes
    json :changes
  end
end
