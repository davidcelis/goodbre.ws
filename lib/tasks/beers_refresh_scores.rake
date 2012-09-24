namespace :beers do
  desc "Regenerate all scores for beers"
  task :refresh_scores => :environment do
    Beer.all.each do |b|
      b.send :update_score
    end
  end
end
