class Style < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :beers

  before_create :set_permalink

  def to_param
    self.permalink
  end

  def self.from_param(param)
    self.where(:permalink => param).first
  end

  private

  def set_permalink
    self.permalink = self.name.parameterize
  end
end
