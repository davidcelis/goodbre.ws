ThinkingSphinx::Index.define :beer, :with => :active_record do
    indexes name, description
    indexes brewery.name, :as => :brewery
    indexes style.name, :as => :style

    indexes brewery(:name), :as => :brewery
    indexes style(:name), :as => :style
  end
