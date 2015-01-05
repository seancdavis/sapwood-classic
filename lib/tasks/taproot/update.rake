namespace :taproot do

  desc 'Pull Taproot repo and update'
  task :update => :environment do
    [
      "git pull origin v0-stable",
      "bundle install",
      "RAILS_ENV=#{Rails.env} bundle exec rake db:migrate",
      "RAILS_ENV=#{Rails.env} bundle exec rake assets:precompile",
      "RAILS_ENV=#{Rails.env} bundle exec rake assets:clean"
    ].each { |cmd| system(cmd) }
  end

end
