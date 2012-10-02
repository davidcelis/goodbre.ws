class TempBeersController < ApplicationController
  before_filter :ensure_admin!, :only => :approve

  # GET /beers/suggested
  def index
    @beer = TempBeer.page(params[:page])
  end

  # GET /beers/suggest
  def new
    @beer = TempBeer.new
  end

  # POST /beers/
  def create
    @beer = TempBeer.new(params[:temp_beer])

    if @beer.save
      redirect_to suggested_beers_path
    else
      render :new, :status => :unprocessable_entity
    end
  end

  # POST /beers/:id/approve
  def approve
    @temp_beer = TempBeer.find(params[:id])
    @beer = Beer.new(
      :name => @temp_beer.name,
      :abv => @temp_beer.abv,
      :discontinued => @temp_beer.discontinued,
      :brewery_id => @temp_beer.brewery_id
    )

    if @beer.save
      @temp_beer.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
