class ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl

  layout :set_layout

  protected

    def handle_unverified_request
      super
      cookies.delete(:auth_token)
      @current_user = nil
    end

  private

    def current_user
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    end

    def signed_in?
      !!current_user
    end

    def ensure_signed_in!
      redirect_to sign_in_account_path, :alert => 'Please sign in to continue.' unless signed_in?
    end

    # lol
    def ensure_admin!
      current_user.username == 'davidcelis'
    end

    helper_method :current_user, :signed_in?

    def set_layout
      if request.headers['X-PJAX']
        'pjax'
      else
        'application'
      end
    end
end
