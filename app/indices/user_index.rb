require Rails.root.join('app', 'models', 'user')

ThinkingSphinx::Index.define :user, :with => :active_record do
  indexes username
end
