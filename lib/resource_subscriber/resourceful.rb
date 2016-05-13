module ResourceSubscriber
  module Resourceful
    extend ::ActiveSupport::Concern

    def created
      binding.pry


    end
  end
end
