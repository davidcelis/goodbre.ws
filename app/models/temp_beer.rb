class TempBeer < ActiveRecord::Base
  belongs_to :temp_brewery
  belongs_to :style
  attr_accessible :abv, :discontinued, :name, :brewery_id

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end
end
