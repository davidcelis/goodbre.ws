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
      flash.now.alert = 'Invalid username/email or password'
      render 'new'
    end
  end

  # POST /sign_out
  def sign_out
    cookies.delete :auth_token
    redirect_to welcome_path, :notice => 'Signed out.'
  end
end
