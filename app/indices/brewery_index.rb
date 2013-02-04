require Rails.root.join('app', 'models', 'brewery')

ThinkingSphinx::Index.define :brewery, :with => :active_record do
  indexes name, description
end
