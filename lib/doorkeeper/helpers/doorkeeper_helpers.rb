module Doorkeeper
  module Helpers::Controller
    alias_method :old, :get_error_response_from_exception

    def get_error_response_from_exception(exception)
      error_name = case exception
                     when Errors::InvalidResourceOwner
                       :invalid_resource_owner
                   end
      if error_name
        OAuth::ErrorResponse.new name: error_name, state: params[:state]
      else
        old exception
      end
    end
  end

  module Errors
    class InvalidResourceOwner < DoorkeeperError; end
  end
end