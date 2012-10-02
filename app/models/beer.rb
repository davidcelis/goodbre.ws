class Beer < ActiveRecord::Base
  attr_accessible :abv, :description, :discontinued, :name, :brewery_id
  belongs_to :brewery
  belongs_to :style

  validates_presence_of :name

  # Sphinx
  define_index do
    indexes :name
    indexes :description

    indexes brewery(:name), :as => :brewery
    indexes style(:name), :as => :style
  end

  def self.paginate(options = {})
    page(options[:page]).per(options[:per_page])
  end
end
