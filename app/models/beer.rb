class Beer < ActiveRecord::Base
  attr_accessible :abv, :description, :discontinued, :name
  belongs_to :brewery
  belongs_to :style

  validates_presence_of :name
end
