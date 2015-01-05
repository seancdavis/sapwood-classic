namespace :taproot do

  desc 'Update Taproot repo on v0-stable'
  task :update => :environment do
    TaprootAction.new.update_repo
  end

end
