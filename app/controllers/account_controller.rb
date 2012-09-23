class AccountController < ApplicationController
  # GET /account/new
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  # POST /account
  def create
    @user = User.new params[:user]

    respond_to do |format|
      if @user.save
        cookies.permanent[:auth_token] = @user.auth_token
        format.html { redirect_to root_path, :notice => 'Welcome to goodbre.ws!' }
      else
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
  end

  # GET /account/settings
  def edit
  end

  # PUT /account
  def update
    respond_to do |format|
      if current_user.update_attributes params[:user]
        format.html { redirect_to current_user, :notice => 'Settings saved.' }
      else
        format.html { render :action => :edit }
      end
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
