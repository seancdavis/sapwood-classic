namespace :taproot do

  namespace :project do

    desc 'Create an existing Taproot project'
    task :import => :environment do
      ARGV.each { |a| task a.to_sym do ; end }
      # unless ARGV.size == 3
      #   puts "Usage: bundle exec rake taproot:new:project [NAME] [REPO_URL]"
      #   exit
      # end
      # title = ARGV[1]
      # git_url = ARGV[2]
      # # task name.to_sym do ; end
    end

  end

end
