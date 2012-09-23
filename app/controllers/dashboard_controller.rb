class DashboardController < ApplicationController
  before_filter :ensure_signed_in!

  # GET /dashboard
  def index
    @beers = Beer.top(10)
    render :dashboard
  end

  # GET /dashboard/recommendations
  def recommendations
    @beers = current_user.recommended_beers.includes(:brewery, :style)
    render :dashboard
  end

  # GET /dashboard/likes
  def likes
    @beers = current_user.liked_beers.includes(:brewery, :style)
    render :dashboard
  end

  # GET /dashboard/dislikes
  def dislikes
    @beers = current_user.disliked_beers.includes(:brewery, :style)
    render :dashboard
  end

  # GET /dashboard/fridge
  def fridge
    @beers = current_user.stashed_beers.includes(:brewery, :style)
    render :dashboard
  end

  # GET /dashboard/similar
  def similar
    @users = current_user.similar_raters
  end
end
