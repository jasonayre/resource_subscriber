module ResourceSubscriber
  module AutoInject
    extend ::ActiveSupport::Concern

    included do
      class_attribute :_required_dependencies
      self._required_dependencies = ::Set.new
    end

    def initialize(*args, **options)
      super(**options)
      self.class.ensure_required_dependencies(**options)

      options.each_pair do |k,v|
        instance_variable_set(:"@#{k}", v)
      end
    end

    module ClassMethods
      def required_dependencies(*args)
        self._required_dependencies = self._required_dependencies + args
      end

      def ensure_required_dependencies(**options)
        _missing_dependencies = _required_dependencies.select{ |dep| !options.key?(dep) }
        raise ::StandardError.new("Missing Required Dependencies #{_missing_dependencies.join(',')}", _missing_dependencies) if _missing_dependencies.any?
      end
    end
  end
end
