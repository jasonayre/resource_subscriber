module ResourceSubscriber
  class Config < ::Trax::Core::Types::Struct
    string :exchange, :default => "events"
  end
end
