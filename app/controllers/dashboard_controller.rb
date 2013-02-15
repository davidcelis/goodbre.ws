class DashboardController < ApplicationController
  before_filter :ensure_signed_in!

  # GET /dashboard
  def index
    @beers = Beer.includes(:breweries, :style).top(100)
    @beers = Kaminari.paginate_array(@beers).page(params[:page]).per(25)
    render :dashboard
  end

  # GET /dashboard/recommendations
  def recommendations
    @beers = current_user.recommended_beers.includes(:breweries, :style).page(params[:page])

    if @beers.empty?
      if current_user.rated_anything?
        @message = "Not seeing recommendations yet? Please see <a href='http://davidcelis.com/blog/2012/10/03/the-state-of-recommendations-in-goodbrews/' target='_blank' rel='nofollow'>this note</a> for more info."
      else
        @message = "Rate a beer so we can start working on your recommendations! Search for a beer using the bar at the top."
      end
    end

    render :dashboard
  end

  # GET /dashboard/likes
  def likes
    @beers = current_user.liked_beers.includes(:breweries, :style).page(params[:page])
    @message = "You haven't liked any beers yet. Search for a beer to like using the bar at the top!" if @beers.empty?
    render :dashboard
  end

  # GET /dashboard/dislikes
  def dislikes
    @beers = current_user.disliked_beers.includes(:breweries, :style).page(params[:page])
    @message = "Disliking beers is important too! Search for a beer you don't like using the bar at the top." if @beers.empty?
    render :dashboard
  end

  # GET /dashboard/fridge
  def fridge
    @beers = current_user.bookmarked_beers.includes(:breweries, :style).page(params[:page])
    @message = "Click the bookmark on beers you're planning to try next, especially if you've already got 'em!" if @beers.empty?
    render :dashboard
  end

  # GET /dashboard/similar
  def similar
    @users = current_user.similar_raters
  end
end
