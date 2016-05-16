module ResourceSubscriber
  class Changes < SimpleDelegator
    def initialize(changes)
      @changes = changes.with_indifferent_access
    end

    def __getobj__
      @changes
    end

    def was_changed?(attribute_name, to:nil, from:nil)
      result = true
      value = self[attribute_name]
      result &&= !!value
      result &&= self.key?(attribute_name)
      result &&= (to == self[attribute_name][1]) if to
      result &&= (from == self[attribute_name][0]) if from
      result
    end
  end
end
