require Rails.root.join('app', 'models', 'beer')
require Rails.root.join('app', 'models', 'style')
require Rails.root.join('app', 'models', 'brewery')

ThinkingSphinx::Index.define :beer, :with => :active_record do
    indexes name, description
    indexes brewery.name, :as => :brewery
    indexes style.name, :as => :style

    indexes brewery(:name), :as => :brewery
    indexes style(:name), :as => :style
  end
