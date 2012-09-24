class Brewery < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :closed, :description, :name, :permalink, :website
  has_many :beers

  before_create :set_permalink
  validates_presence_of :name

  def to_param
    self.permalink
  end

  def address
    <<-END.strip_heredoc.gsub(/\n+/, "\n")
      #{street1}
      #{street2}
      #{city}, #{region} #{zip} #{country}
    END
  end

  def self.from_param(param)
    self.where(:permalink => param).first
  end

  private

  def set_permalink
    self.permalink = self.name.parameterize
  end
end
