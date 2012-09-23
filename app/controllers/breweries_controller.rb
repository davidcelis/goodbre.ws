class BreweriesController < ApplicationController
  # GET /breweries/:id
  def show
    @brewery = Brewery.from_param(params[:id]).includes(:beers)
    @beers = @brewery.beers.where(:discontinued => false)
  end

  def discontinued
    @brewery = Brewery.from_param(params[:id]).includes(:beers)
    @beers = @brewery.beers.where(:discontinued => true)
    render :show
  end
end
