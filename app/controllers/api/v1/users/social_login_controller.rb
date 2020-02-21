class Api::V1::Users::SocialLoginController < Api::BaseController
  skip_before_action :authenticate_user_for_api

  def create
    @user = User.where(email: params['user']['email']).first
    unless @user
      password = Devise.friendly_token[0, 20]
      @user = User.new(email: params['user']['email'], name: params['user']['name'], password: password)
      @user.confirmed_at = DateTime.now
      @user.save
    end
    render action_name, status: status
  end

  protected

  def test_facebook_login
    OmniAuth::Strategies
  end
end
