class TempBrewery < ActiveRecord::Base
  attr_accessible :closed, :name, :website
  has_many :temp_beers

  validates_presence_of :name

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end
end
