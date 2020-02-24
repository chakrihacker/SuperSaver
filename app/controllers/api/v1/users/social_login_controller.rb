class Api::V1::Users::SocialLoginController < Api::BaseController
  skip_before_action :authenticate_user_for_api

  def create
    user = social_login(params[:provider], params[:token])
    if user[:errors].nil?
      @user = User.where(email: user['email']).first
      unless @user
        puts user
        puts 'here'
        password = Devise.friendly_token[0, 20]
        puts user[:email]
        @user = User.new(email: user['email'], name: user['name'], password: password)
        @user.confirmed_at = DateTime.now
        @user.save
      end
      render action_name, status: status
    else
      render json: user[:errors], status: :unprocessable_entity
    end
  end

  protected

  def social_login(provider, token)
    if provider == 'google'
      google_verification(token)
    elsif provider == 'facebook'
      facebook_verification(token) if provider == 'facebook'
    else
      { errors: { 'error': 'Something went wrong' } }
    end
  end

  def google_verification(token)
    # Ping google for details
    response = HTTParty.get("https://oauth2.googleapis.com/tokeninfo?id_token=#{token}")
    parsed_response = response.parsed_response
    if parsed_response['aud']
      # Get aud
      aud = parsed_response['aud'].split('.')[0]
      if ENV['GOOGLE_CLIENT_ID'].include? aud
        return parsed_response
      else
        return { errors: { 'error': 'Something went wrong here' } }
      end
    end
    { errors: { 'error': 'Something went wrong here 2' } }
  end

  def facebook_verification(token)
    puts "facebook verification #{token}"
  end
end
