class TempBeer < ActiveRecord::Base
  belongs_to :temp_brewery
  belongs_to :brewery
  belongs_to :style
  attr_accessible :abv, :discontinued, :name, :brewery_id, :style_id

  validates_presence_of :name
  validates_presence_of :brewery, :message => 'must choose one'
  validates_numericality_of :abv, :allow_nil => true, :message => 'must be a number'
  validates_presence_of :style, :message => 'must choose one'

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end
end
