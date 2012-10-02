class TempBeersController < ApplicationController
  before_filter :ensure_admin!, :except => [:new, :create]

  # GET /beers/suggested
  def index
    @temp_beers = TempBeer.page(params[:page])
  end

  # GET /beers/suggest
  def new
    @temp_beer = TempBeer.new
    @breweries = Brewery.select([:id, :name])
    @styles = Style.where('id > 2').select([:id, :name])
  end

  # POST /beers/
  def create
    @temp_beer = TempBeer.new(params[:temp_beer])

    if @temp_beer.save
      redirect_to root_path, :notice => "Thanks! We'll review this soon."
    else
      @breweries = Brewery.select([:id, :name])
      @styles = Style.where('id > 2').select([:id, :name])
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
      redirect_to suggested_beers_path
    else
      head :unprocessable_entity
    end
  end

  # DELETE /beers/:id/dismiss
  def dismiss
    TempBeer.find(params[:id]).destroy

    redirect_to suggested_beers_path
  end
end
