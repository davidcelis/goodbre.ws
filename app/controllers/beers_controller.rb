class BeersController < ApplicationController
  before_filter :ensure_signed_in!

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

  # POST /beers/:id/ignore.json
  def ignore
    @beer = Beer.find params[:id]

    if current_user.ignore @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /beers/:id/ignore.json
  def unignore
    @beer = Beer.find params[:id]

    if current_user.unignore @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # POST /beers/:id/stash.json
  def stash
    @beer = Beer.find params[:id]

    if current_user.stash @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /beers/:id/stash.json
  def unstash
    @beer = Beer.find params[:id]

    if current_user.unstash @beer
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
