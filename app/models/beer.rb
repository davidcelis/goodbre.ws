require_relative 'user'

class Beer < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search, against: [:name, :description],
                           associated_against: {
                             breweries: :name,
                             style:   :name
                           },
                           using: {
                             tsearch: { prefix: true }
                           }

  attr_accessible :abv, :description, :discontinued, :name, :style_id, :style
  has_and_belongs_to_many :breweries
  belongs_to :style

  validates_presence_of :name

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end
end
