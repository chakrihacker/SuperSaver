module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        skip_before_action :authenticate_user_for_api
        respond_to :json

        protected

        def respond_with(*)
          status = @user.errors.empty? ? :ok : :unprocessable_entity

          render action_name, status: status
        end
      end
    end
  end
end
