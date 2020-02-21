json.data do
  if @user.errors.empty?
    json.id @user.id
    json.email @user.email
    json.jwt_token JwtWrapper.encode(user_id: @user.id)
  else
    json.errors @user.errors
  end
end