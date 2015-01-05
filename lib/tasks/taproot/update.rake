namespace :taproot do

  namespace :update do

    desc 'Update Taproot repo on v0-stable'
    task :v0 => :environment do
      if Rails.env.production?
        cmds = [
          "git pull origin v0-stable",
          "bundle install",
          "RAILS_ENV=#{Rails.env} bundle exec rake db:migrate",
          "RAILS_ENV=#{Rails.env} bundle exec rake assets:precompile",
          "RAILS_ENV=#{Rails.env} bundle exec rake assets:clean",
          "sudo service unicorn_taproot restart"
        ]
      else
        cmds = [
          "git pull origin v0-stable",
          "bundle install",
          "RAILS_ENV=#{Rails.env} bundle exec rake db:migrate"
        ]
      end
      cmds.each { |cmd| system(cmd) }
    end

  end

end
