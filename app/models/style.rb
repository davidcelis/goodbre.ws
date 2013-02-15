class Style < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :beers

  before_create :set_slug

  def to_param
    self.slug
  end

  def self.from_param(param)
    self.where(:slug => param).first
  end

  private

  def set_slug
    self.slug = self.name.parameterize
  end
end
