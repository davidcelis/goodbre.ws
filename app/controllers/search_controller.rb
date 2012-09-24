class SearchController < ApplicationController
  # GET /search/beers
  def beers
    @beers = Beer.search params[:q], :page => (params[:page] || 1)
  end

  # GET /search/breweries
  def breweries
    @breweries = Brewery.search params[:q], :page => (params[:page] || 1)
  end

  # GET /search/users
  def users
    @users = User.search params[:q], :page => (params[:page] || 1)
  end
end
