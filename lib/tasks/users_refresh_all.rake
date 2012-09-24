namespace :users do
  desc "Regenerate all users' similarity values and recommendations"
  task :refresh_all => :environment do
    User.all.each do |u|
      u.send :update_similarities
      u.send :update_recommendations
    end
  end
end
