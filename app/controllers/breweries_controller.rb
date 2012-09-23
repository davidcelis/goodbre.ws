class BreweriesController < ApplicationController
  # GET /breweries/:id
  def show
    @brewery = Brewery.from_param params[:id]
  end
end
