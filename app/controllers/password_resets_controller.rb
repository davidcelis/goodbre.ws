class PasswordResetsController < ApplicationController
  # GET /account/password_reset
  def new
  end

  # POST /account/password_resets
  def create
    user = User.find_by_email params[:email]
    user.send_password_reset if user
    redirect_to sign_in_users_path, :notice => 'Email sent with password reset instructions.'
  end

  # GET /account/password_resets/:id
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  # PUT /account/password_resets/:id
  def update
    @user = User.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => 'Your password reset has expired.'
    elsif @user.update_attributes(params[:user])
      redirect_to root_path, :notice => 'Your password has been reset!'
    else
      render :edit
    end
  end
end
