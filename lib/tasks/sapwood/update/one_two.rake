namespace :sapwood do
  namespace :update do
    task :one_two => :environment do
      Page.all.each(&:save!)
    end
  end
end
