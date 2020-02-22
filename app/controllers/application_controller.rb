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

  def set_pagination_header(name)
    scope = instance_variable_get("@#{name}")
    request_params = request.query_parameters
    unless request_params.empty?
      url_without_params = request.original_url.slice(0..(request.original_url.index('?') - 1))
    end
    url_without_params ||= request.original_url

    page = {}
    page[:first] = 1 if scope.total_pages > 1 && !scope.first_page?
    if scope.total_pages > 1 && !scope.last_page?
      page[:last] = scope.total_pages
    end
    page[:next] = scope.current_page + 1 unless scope.last_page?
    page[:prev] = scope.current_page - 1 unless scope.first_page?

    pagination_links = []
    page.each do |k, v|
      new_request_hash = request_params.merge({ page: v })
      pagination_links << "<#{url_without_params}?#{new_request_hash.to_param}>; rel=\"#{k}\""
    end
    headers['Link'] = pagination_links.join(', ')
  end
end
