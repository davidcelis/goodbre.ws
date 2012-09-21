class AuthenticationController < ApplicationController
  # GET /sign_in
  def new
  end

  # POST /sign_in
  def create
    user = User.find_by_login params[:login]

    if user && user.authenticate(params[:password])
      cookies.permanent[:auth_token] = user.auth_token
      cookies.permanent[:username] = user.username

      redirect_to dashboard_path, :notice => 'Welcome back!'
    else
      flash.now.alert = 'Invalid username/email or password'
      render 'new'
    end
  end

  # POST /sign_out
  def destroy
    cookies.delete :auth_token
    cookies.delete :username
    redirect_to welcome_path, :notice => 'Signed out.'
  end
end