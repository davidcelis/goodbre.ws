class AuthenticationController < ApplicationController
  # GET /sign_in
  def sign_in
  end

  # POST /sign_in
  def authenticate
    user = User.find_by_login params[:login]

    if user && user.authenticate(params[:password])
      cookies.permanent[:auth_token] = user.auth_token
      redirect_to dashboard_path, :notice => 'Welcome back!'
    else
      redirect_to sign_in_account_path, :notice => 'Invalid login/password combination'
    end
  end

  # POST /sign_out
  def sign_out
    cookies.delete :auth_token
    redirect_to welcome_path
  end
end
