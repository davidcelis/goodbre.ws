class BeersController < ApplicationController
  before_filter :ensure_signed_in!
  respond_to :json

  # POST /beers/:id/like.json
  def like
    @beer = Beer.find params[:id]

    if current_user.like @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /beers/:id/like.json
  def unlike
    @beer = Beer.find params[:id]

    if current_user.unlike @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # POST /beers/:id/dislike.json
  def dislike
    @beer = Beer.find params[:id]

    if current_user.dislike @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /beers/:id/dislike.json
  def undislike
    @beer = Beer.find params[:id]

    if current_user.undislike @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # POST /beers/:id/hide.json
  def hide
    @beer = Beer.find params[:id]

    if current_user.hide @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /beers/:id/hide.json
  def unhide
    @beer = Beer.find params[:id]

    if current_user.unhide @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # POST /beers/:id/bookmark.json
  def bookmark
    @beer = Beer.find params[:id]

    if current_user.bookmark @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /beers/:id/bookmark.json
  def unbookmark
    @beer = Beer.find params[:id]

    if current_user.unbookmark @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
