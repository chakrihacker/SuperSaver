module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        skip_before_action :authenticate_user_for_api
        respond_to :json
        after_action -> { request.session_options[:skip] = true }
      end
    end
  end
end
