class TempBrewery < ActiveRecord::Base
  attr_accessible :closed, :name, :website
  has_many :temp_beers

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end
end
