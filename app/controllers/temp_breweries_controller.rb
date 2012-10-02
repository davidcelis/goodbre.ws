class TempBreweriesController < ApplicationController
  before_filter :ensure_admin!, :except => [:new, :create]

  # GET /breweries/suggested
  def index
    @temp_breweries = TempBrewery.page(params[:page])
  end

  # GET /breweries/suggest
  def new
    @temp_brewery = TempBrewery.new
  end

  # POST /breweries/
  def create
    @temp_brewery = TempBrewery.new(params[:temp_brewery])

    if @temp_brewery.save
      redirect_to root_path, :notice => "Thanks! We'll review this soon."
    else
      render :new, :status => :unprocessable_entity
    end
  end

  # POST /breweries/:id/approve
  def approve
    @temp_brewery = TempBrewery.find(params[:id])
    @brewery = Brewery.new(
      :name => @temp_brewery.name,
      :website => ('http://' + @temp_brewery.website)
    )

    if @brewery.save
      @temp_brewery.destroy
      redirect_to suggested_breweries_path
    else
      head :unprocessable_entity
    end
  end

  # DELETE /breweries/:id/dismiss
  def dismiss
    TempBrewery.find(params[:id]).destroy

    redirect_to suggested_breweries_path
  end
end
