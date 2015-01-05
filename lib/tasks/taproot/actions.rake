namespace :taproot do

  desc 'Update Taproot repo on v0-stable'
  task :update => :environment do
    TaprootAction.new.update_repo
  end

  desc 'Restart server (production)'
  task :restart_server => :environment do
    TaprootAction.new.restart_server
  end

  desc 'Stop server (production)'
  task :stop_server => :environment do
    TaprootAction.new.stop_server
  end

  desc 'Start server (production)'
  task :start_server => :environment do
    TaprootAction.new.start_server
  end

  desc 'Restart sidekiq server (production)'
  task :restart_sidekiq => :environment do
    TaprootAction.new.restart_sidekiq
  end

end
