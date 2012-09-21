class AccountController < ApplicationController
  # GET /account/new
  def new
  end

  # POST /account
  def create
  end

  # GET /account/settings
  def edit
  end

  # PUT /account
  def update
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
