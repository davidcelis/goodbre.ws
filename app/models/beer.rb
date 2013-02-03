class Beer < ActiveRecord::Base
  attr_accessible :abv, :description, :discontinued, :name, :brewery_id, :style_id
  belongs_to :brewery
  belongs_to :style

  validates_presence_of :name

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end
end
