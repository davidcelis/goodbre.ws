namespace :users do
  desc "Regenerate all users' recommendations"
  task :frefresh_recommendations => :environment do
    User.all.each do |u|
      u.send :update_recommendations
    end
  end
end
