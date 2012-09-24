class Brewery < ActiveRecord::Base
  attr_accessible :description, :name, :permalink, :website
  has_many :beers

  before_create :set_permalink
  validates_presence_of :name

  # Sphinx
  define_index do
    indexes :name
    indexes :description
  end

  def to_param
    self.permalink
  end

  def to_indexed_json
    to_json(:include => { :beers => { :only => [:name] } } )
  end

  def self.from_param(param)
    self.where(:permalink => param).first
  end

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end

  private

  def set_permalink
    self.permalink = self.name.parameterize
  end
end
