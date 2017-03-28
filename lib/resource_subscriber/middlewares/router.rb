module ResourceSubscriber
  module Middlewares
    class Router
      include ::ActionSubscriber::Logging

      def initialize(app)
        @app = app
      end

      def call(env)
        logger.info "START #{env.message_id} #{env.subscriber}##{env.action}"

        if env["resource"]
          env.subscriber.run_action_with_filters(env, env.action)
        else
          env.acknowledge
        end

        logger.info "FINISHED #{env.message_id}"
      end
    end
  end
end
