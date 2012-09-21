class BreweriesController < ApplicationController
  # GET /breweries/:id
  def show
    @brewery = Brewery.from_param params[:id]

    respond_to do |format|
      format.html # show.html.haml
    end
  end
end
