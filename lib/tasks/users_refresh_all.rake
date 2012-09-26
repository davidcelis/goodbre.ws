namespace :users do
  desc "Regenerate all users' similarity values and recommendations"
  task :refresh_all => :environment do
    User.where('id > 209').each do |u|
      puts "Updating user #{u.id}'s similarities..."
      u.send :update_similarities
      puts "Updating user #{u.id}'s recommendations..."
      u.send :update_recommendations
    end
  end
end
