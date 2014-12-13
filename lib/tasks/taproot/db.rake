namespace :taproot do

  namespace :db do

    desc 'Backup database'
    task :backup => :environment do
      TaprootDatabase.new.backup
    end

    desc 'Backup database'
    task :sync => :environment do
      TaprootDatabase.new.sync
    end

  end

end