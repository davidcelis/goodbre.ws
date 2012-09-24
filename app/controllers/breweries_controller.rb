class BreweriesController < ApplicationController
  # GET /breweries/:id
  def show
    @brewery = Brewery.includes(:beers).from_param(params[:id])
    @beers = @brewery.beers.where('discontinued IS NOT true').order(:name).page(params[:page])
  end

  def discontinued
    @brewery = Brewery.includes(:beers).from_param(params[:id])
    @beers = @brewery.beers.where(:discontinued => true).order(:name).page(params[:page])
    render :show
  end
end
