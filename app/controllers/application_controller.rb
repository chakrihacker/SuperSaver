class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session,
                       unless: -> { request.format.json? }

  before_action :authenticate_user!, unless: :json_request?
  before_action :authenticate_user_for_api, if: :json_request?
  attr_reader :current_user


  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || home_path
  end

  def json_request?
    request.format.json?
  end

  def authenticate_user_for_api
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end