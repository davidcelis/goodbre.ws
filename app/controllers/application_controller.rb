class ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl

  layout :set_layout

  private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def signed_in?
    !!current_user
  end

  def ensure_signed_in!
    redirect_to sign_in_path, :alert => 'Please sign in to continue.' unless signed_in?
  end

  helper_method :current_user, :signed_in?

  def set_layout
    if request.headers['X-PJAX']
      false
    else
      'application'
    end
  end
end
