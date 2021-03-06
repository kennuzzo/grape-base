class API::Utils::Logger
  def initialize(app)
    @app = app
  end

  def call(env)
    payload = {
      remote_addr:    env['REMOTE_ADDR'],
      request_method: env['REQUEST_METHOD'],
      request_path:   env['PATH_INFO'],
      request_query:  env['QUERY_STRING'],
      x_organization: env['HTTP_X_ORGANIZATION']
    }

    # you can find the subscriber at config/initializers/grape_notifications.rb
    ActiveSupport::Notifications.instrument "grape.request", payload do
      @app.call(env).tap do |response|
        if payload[:params].present? && payload[:params] = env["api.endpoint"].params
        payload[:params] = env["api.endpoint"].params.to_hash 
        payload[:params].delete("route_info")
        payload[:params].delete("format")
      end
        payload[:response_status] = response[0]
      end
    end
  end
end