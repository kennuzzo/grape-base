module API
  class Dispatch < Grape::API
    require 'api/utils/as_json_formatter'
    use Rack::ConditionalGet
    use Rack::ETag

    rescue_from :all do |e|
      eclass = e.class.to_s
      message = "OAuth error: #{e.to_s}" if eclass.match('WineBouncer::Errors')
      status = case
      when eclass.match('OAuthUnauthorizedError')
        401
      when eclass.match('OAuthForbiddenError')
        403
      when eclass.match('Grape::Exceptions::ValidationErrors'), eclass.match('RecordInvalid')
        400
      when eclass.match('RecordNotFound'), e.message.match(/unable to find/i).present?
        404
      else
        (e.respond_to? :status) && e.status || 500
      end
      opts = { error: "#{message || e.message}" }
      opts[:trace] = e.backtrace[0,10] unless Rails.env.production?
      Rack::Response.new(opts.to_json, status, {
                           'Content-Type' => "application/json",
                           'Access-Control-Allow-Origin' => '*',
                           'Access-Control-Request-Method' => '*',
      }).finish
    end


    cascade false
    default_format :json
    format :json
    formatter :as_json, Grape::Formatter::AsJson
    content_type :json, 'application/json'


    mount API::V1::Root

  end

  Base = Rack::Builder.new do
    use API::Utils::Logger
    run API::Dispatch
  end
end
