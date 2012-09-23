class AccountController < ApplicationController
  before_filter :ensure_signed_in!, :only => [:edit, :update, :destroy, :ignored]
  # GET /account/new
  def new
    @user = User.new
  end

  # POST /account
  def create
    @user = User.new params[:user]

    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token
      redirect_to root_path, :notice => 'Welcome to goodbre.ws!'
    else
      render :action => :new, :status => :unprocessable_entity
    end
  end

  # GET /account/settings
  def edit
  end

  # PUT /account
  def update
    unless current_user.authenticate(params[:user].delete(:current_password))
      current_user.errors.add(:current_password, 'was incorrect')
      render :action => :edit and return
    end

    if current_user.update_attributes params[:user]
      redirect_to dashboard_path
    else
      render :action => :edit
    end
  end

  # DELETE /account
  def destroy
    current_user.destroy
    cookies.delete :auth_token
    redirect_to welcome_path, :notice => 'Come back some day!'
  end

  # GET /account/ignored
  def ignored
    @beers = current_user.ignored_beers
  end
end
