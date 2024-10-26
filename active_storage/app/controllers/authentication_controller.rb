class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    begin
      account = Account.find_by(email: params[:email])
      if account&.authenticate(params[:password])
        token = JsonWebToken.encode({
          account_id: account.id
        })
        render json: {
          token: token,
          exp: (Time.now + 1.hours.to_i).strftime("%m-%d-%Y %H:%M"),
          account: account
        }, status: :ok
      else
        render json: {
          errors: "Invalid username or password"
        }, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::EncodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end


  # POST /auth/decode
  def decode
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = JsonWebToken.decode(header)
      render json: {
        decodado: @decoded
      }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
