class Beer < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :abv, :description, :discontinued, :name
  belongs_to :brewery
  belongs_to :style

  validates_presence_of :name
end
