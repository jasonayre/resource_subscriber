module ResourceSubscriber
  class PublisherConfig < ::Trax::Core::Types::Struct
    string :exchange, :default => "events"
    string :routing_key, :default => ""
  end
end
