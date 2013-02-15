class PagesController < ApplicationController
  # GET /welcome
  def welcome
    @beers = Beer.includes(:breweries, :style).top(10)
  end

  # GET /about
  def about
  end

  # GET /privacy
  def privacy
  end

  # GET /terms
  def terms
  end
end
