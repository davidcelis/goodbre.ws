class Brewery < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search, against: [:name, :description]

  attr_accessible :description, :name, :slug, :website
  has_and_belongs_to_many :beers
  has_many :temp_beers

  before_create :set_slug
  validates_presence_of :name

  def to_param
    self.slug
  end

  def to_indexed_json
    to_json(:include => { :beers => { :only => [:name] } } )
  end

  def self.from_param(param)
    self.where(:slug => param).first
  end

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end

  private

  def set_slug
    self.slug = self.name.parameterize
  end
end
