class Api::V1::AuthController < ApiController

  before_action :authenticate_user!, only: :logout

  # POST /api/v1/login
  def login
    success = false

    if params[:email] && params[:password]
      user = User.find_by_email(params[:email])
      success = user && user.valid_password?(params[:password])
    end

    if success
      render json: {
        message: "ok",
        auth_token: user.authentication_token
      }
    else
      render json: { message:  "Email or Password is wrong" }, status:  401
    end
  end
end
