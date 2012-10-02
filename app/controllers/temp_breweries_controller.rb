class TempBreweriesController < ApplicationController
  before_filter :ensure_admin!, :only => :approve

  # GET /breweries/suggested
  def index
    @brewery = TempBrewery.page(params[:page])
  end

  # GET /breweries/suggest
  def new
    @brewery = TempBrewery.new
  end

  # POST /breweries/
  def create
    @brewery = TempBrewery.new(params[:temp_brewery])

    if @brewery.save
      redirect_to suggested_breweries_path
    else
      render :new, :status => :unprocessable_entity
    end
  end

  # POST /breweries/:id/approve
  def approve
    @temp_brewery = TempBrewery.find(params[:id])
    @brewery = Brewery.new(
      :name => @temp_brewery.name,
      :closed => @temp_brewery.closed,
      :website => @temp_brewery.website
    )

    if @brewery.save
      @temp_brewery.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
