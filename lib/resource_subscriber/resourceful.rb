module ResourceSubscriber
  module Resourceful
    extend ::ActiveSupport::Concern

    attr_accessor :resource, :changes

    def initialize(*args)
      super(*args)

      @resource = env["resource"]
      @changes = env["changes"]
    end

    def was_changed?(*args, **options)
      @changes.was_changed?(*args, **options)
    end
  end
end
