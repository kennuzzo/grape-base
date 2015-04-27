module API
  module Utils
    module Helpers


      # if you are wondering where doorkeeper_access_token and resource_owner is coming from: https://github.com/antek-drzewiecki/wine_bouncer#token-information

      def current_token
        doorkeeper_access_token
      end

      def current_user
        resource_owner.first if resource_owner

      end

      def token_info(token = nil)
        available_token = token.presence || current_token
        Doorkeeper::OAuth::TokenResponse.new(available_token).body if available_token.present?
      end

      #with cancancan
      #def authorize!(*args)
      # With cancan
      # you already implement current_user helper :)
      #::Ability.new(current_user).authorize!(*args)
      #end

      def authorize!(message = "")
        error!( message.presence || 'not authorized', 400) unless current_user.present?
      end

      # declared is a Grape helper it will do the same work that strong params is doing.
      def permitted_params
        declared(params, include_missing: false)
      end

    end
  end
end
