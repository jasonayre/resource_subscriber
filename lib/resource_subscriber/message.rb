module ResourceSubscriber
  class Message < ::Trax::Core::Types::Struct
    string :resource_type
    json :resource
    json :changes
  end
end
