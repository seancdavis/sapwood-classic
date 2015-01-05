# The actions contained within this file help control Taproot and its 
# services without needing to remember so many complicated commands.
# 
# WARNING: Many of the services here are long-running tasks, and others 
# are tied into the Rails server itself. These should always be called 
# from either a rake task or a background worker.
# 
class TaprootAction

  def initialize(service = 'unicorn_taproot')
    @service = service
  end

  # ------------------------------------------ Actions

  def update_repo
    pull
    bundle
    migrate
    if Rails.env.production?
      precompile_assets
      clean_assets
      restart
      restart_sidekiq
    end
  end

  def reload
    if Rails.env.production?
      precompile_assets
      clean_assets
      restart
      restart_sidekiq
    end
  end

  def start_server
    start if Rails.env.production?
  end

  def stop_server
    stop if Rails.env.production?
  end

  def restart_server
    restart if Rails.env.production?
  end

  def restart_sidekiq
    stop_sidekiq
    start_sidekiq
  end

  private

    # ------------------------------------------ Rails Server

    def start
      system("service #{@service} start")
    end

    def stop
      system("service #{@service} stop")
    end

    def restart
      system("service #{@service} restart")
    end

    # ------------------------------------------ Sidekiq

    def start_sidekiq
      system("cd #{Rails.root}; bundle exec sidekiq -d -L log/sidekiq.log -q mailer,5 -q default -e production")
    end

    def stop_sidekiq
      pid = `ps -ef | grep sidekiq | grep -v grep | awk '{print $2}'`
      unless pid.blank?
        system("kill -9 #{pid}")
      end
    end

    # ------------------------------------------ Assets

    def precompile_assets
      system("RAILS_ENV=#{Rails.env} bundle exec rake assets:precompile")
    end

    def clean_assets
      system("RAILS_ENV=#{Rails.env} bundle exec rake assets:clean")
    end

    def bundle
      system("bundle install")
    end

    # ------------------------------------------ Database

    def migrate
      system("RAILS_ENV=#{Rails.env} bundle exec rake db:migrate")
    end

    # ------------------------------------------ Git

    def pull
      branch = 'v0-stable'
      system("cd #{Rails.root}; git checkout #{branch}")
      system("cd #{Rails.root}; git pull origin #{branch}")
    end

end
