namespace :taproot do

  namespace :db do

    desc 'Backup database'
    task :backup => :environment do
      TaprootDatabase.new.backup
    end

  end

end