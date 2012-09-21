class UsersController < ApplicationController
  before_filter :ensure_signed_in!, :only => [:edit, :update, :destroy]

  # GET /users/:id
  def show
    @user = User.from_param params[:id]

    respond_to do |format|
      format.html # show.html.haml
    end
  end

  # GET /users/:id/recommendations
  def recommendations
    @user = User.from_param params[:id]
    @beers = @user.recommended_beers

    respond_to do |format|
      format.html # recommendations.html.haml
    end
  end

  # GET /users/:id/liked
  def liked
    @user = User.from_param params[:id]
    @beers = @user.liked_beers

    respond_with @beers, :api_template => :public
  end

  # GET /users/:id/disliked
  def disliked
    @user = User.from_param params[:id]
    @beers = @user.disliked_beers

    respond_with @beers, :api_template => :public
  end

  # GET /users/:id/ignored.json
  def ignored
    @user = User.from_param params[:id]
    @beers = @user.ignored_beers

    respond_with @beers, :api_template => :public
  end

  # GET /users/:id/stashed.json
  def stashed
    @user = User.from_param params[:id]
    @beers = @user.stashed_beers

    respond_with @beers, :api_template => :public
  end

  # GET /users/:id/similar.json
  def similar
    @user = User.from_param params[:id]
    @users = @user.similar_raters

    respond_with @users, :api_template => :public
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_with(@user, :api_template => :public) do |format|
      format.html # new.html.haml
    end
  end

  # POST /users
  # POST /users.json
  # POST /users.xml
  def create
    @user = User.new params[:user]

    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token

      respond_with(@user, :api_template => :public, :status => :created, :location => @user) do |format|
        format.html { redirect_to dashboard_path, :notice => 'Welcome to goodbre.ws!'}
      end
    else
      respond_with(@user, :api_template => :public, :status => :unprocessable_entity) do |format|
        format.html { render :action => :new }
      end
    end
  end

  # GET /account/settings
  def edit
    @user = current_user
  end

  # PUT /account
  # PUT /account.json
  def update
    params[:user].slice!(:email, :password, :password_confirmation)

    if current_user.update_attributes params[:user]
      respond_with(current_user) do |format|
        format.html { redirect_to current_user }
        format.json { head :ok }
      end
    else
      respond_with(current_user.errors, :status => :unprocessable_entity) do |format|
        format.html { render :action => :edit }
      end
    end
  end

  # DELETE /account
  # DELETE /account.json
  def destroy
    current_user.destroy

    respond_with do |format|
      format.html { redirect_to users_sign_in_path }
      format.json { head :ok }
    end
  end
end
