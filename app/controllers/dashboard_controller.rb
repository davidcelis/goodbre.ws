class DashboardController < ApplicationController
  before_filter :ensure_signed_in!

  # GET /dashboard
  def index
    @beers = Beer.top(10)

    respond_to do |format|
      format.html # top_beers.html.haml
    end
  end

  # GET /dashboard/recommendations
  def recommendations
    @beers = current_user.recommended_beers

    respond_to do |format|
      format.html # recommendations.html.haml
    end
  end

  # GET /dashboard/likes
  def likes
    @beers = current_user.liked_beers

    respond_to do |format|
      format.html # likes.html.haml
    end
  end

  # GET /dashboard/dislikes
  def dislikes
    @beers = current_user.disliked_beers

    respond_to do |format|
      format.html # dislikes.html.haml
    end
  end

  # GET /dashboard/fridge
  def fridge
    @beers = current_user.stashed_beers

    respond_to do |format|
      format.html # fridge.html/haml
    end
  end

  # GET /dashboard/similar
  def similar
    @users = current_user.similar_raters
  end
end
