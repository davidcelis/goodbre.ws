class AccountController < ApplicationController
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
    if current_user.authenticate(params[:user].delete(:current_password)) &&
       current_user.update_attributes(params[:user])
      format.html { redirect_to current_user, :notice => 'Settings saved.' }
    else
      format.html { render :action => :edit }
    end
  end

  # DELETE /account
  def destroy
    current_user.destroy
    redirect_to welcome_path, :notice => 'Come back some day!'
  end

  # GET /account/ignored
  def ignored
    @beers = current_user.ignored_beers
  end
end
