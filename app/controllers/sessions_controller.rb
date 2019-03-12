class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: :login

  def login
    authenticate params[:email], params[:password]
  end

  private

  def authenticate(email, password)
    command = AuthenticateUser.new(email, password).call
    if command
      render json: {
        access_token: command.result,
        status: :ok,
        message: "Login Successful"
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
