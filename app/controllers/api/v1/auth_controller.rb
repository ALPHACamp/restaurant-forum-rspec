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

  # POST /api/v1/logout
  def logout
    # 登入時刷新 token，做為下次登入時比對用，而舊的 token 就失效了
    current_user.generate_authentication_token
    current_user.save!

    render json: { message:  "Ok" }
  end
end
