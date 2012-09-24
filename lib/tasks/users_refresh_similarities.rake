namespace :users do
  desc "Regenerate all users' similarity values"
  task :refresh_similarities => :environment do
    User.all.each do |u|
      u.send :update_similarities
    end
  end
end
