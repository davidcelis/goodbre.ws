class UsersController < ApplicationController
  # GET /users/:id
  def show
    @user = User.from_param params[:id]
    @beers = @user.liked_beers.includes(:brewery, :style)
  end

  # GET /users/:id/dislikes
  def dislikes
    @user = User.from_param params[:id]
    @beers = @user.disliked_beers.includes(:brewery, :style)
    render :show
  end

  # GET /users/:id/fridge
  def fridge
    @user = User.from_param params[:id]
    @beers = @user.stashed_beers.includes(:brewery, :style)
    render :show
  end
end
