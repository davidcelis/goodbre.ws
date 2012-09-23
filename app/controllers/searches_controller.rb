class SearchesController < ApplicationController
  # GET /search/beers
  def beers
    @beers = Beer.search(params[:q])
  end

  # GET /search/breweries
  def breweries
    @breweries = Brewery.search(params[:q])
  end

  # GET /search/users
  def users
    @users = User.search(params[:q])
  end
end
