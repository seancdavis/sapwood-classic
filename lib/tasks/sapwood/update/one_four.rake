require 'fileutils'

namespace :sapwood do
  namespace :update do

    task :one_four => :environment do
      begin
        config_file = File.join(Rails.root,'config','sapwood.yml')
        old_settings = YAML.load_file(config_file)[Rails.env].to_ostruct
      rescue
        backup_config = File.join(Rails.root,'config','taproot.yml')
        old_settings = YAML.load_file(backup_config)[Rails.env].to_ostruct
      end

      used_settings = []

      current_settings = {}

      old_settings.each_pair do |k,v|
        if v.class == OpenStruct
          v.each_pair do |k2, v|
            if v.class == OpenStruct
              v.each_pair do |k3, v|
                current_settings["#{k}_#{k2}_#{k3}".to_sym] = v
              end
            else
              current_settings["#{k}_#{k2}".to_sym] = v
            end
          end
        else
          current_settings[k.to_s.to_sym] = v
        end
      end

      allowed_settings.each do |title, description|
        save_setting(title.to_s, current_settings[title] || '')
      end

      # [
      #   "#{Rails.root}/config/taproot.yml",
      #   "#{Rails.root}/config/sapwood.yml"
      # ].each { |file| FileUtils.rm(file) if File.exists?(file) }

      Site.all.each do |site|
        file = "#{Rails.root}/config/sites/#{site.slug.gsub(/\-/, '_')}.yml"
        if File.exists?(file)
          settings = YAML.load_file(file)[Rails.env].to_ostruct
          settings.each_pair do |k,v|
            if v.class == OpenStruct
              v.each_pair do |k2, v|
                if v.class == OpenStruct
                  v.each_pair do |k3, v|
                    save_site_setting(site, "#{k}_#{k2}_#{k3}", v)
                  end
                else
                  save_site_setting(site, "#{k}_#{k2}", v)
                end
              end
            else
              save_site_setting(site, k.to_s, v)
            end
          end
        end
      end
    end

    def save_setting(k,v)
      if allowed_settings.keys.map(&:to_s).include?(k)
        Setting.create!(
          :title => k,
          :description => allowed_settings[k.to_sym],
          :body => v
        )
        puts "Created setting: #{k}"
      end
    end

    def save_site_setting(site, k, v)
      SiteSetting.create!(
        :site => site,
        :title => k,
        :body => v
      )
      puts "Created setting: #{k}"
    end

    def allowed_settings
      @allowed_settings ||= {
        :site_title => 'The title of your Sapwood application',
        :site_url => 'The domain at which your Sapwood app is hosted',
        :design_colors_primary => 'Primary color (with #)',
        :design_colors_secondary => 'Secondary color (with #)',
        :design_colors_dark => 'Dark color (with #)',
        :design_colors_grey => 'Medium grey color (with #)',
        :design_colors_light => 'White/light color (with #)',
        :dragonfly_secret => 'Random hash for Dragonfly',
        :dragonfly_host => 'Your Sapwood app\'s URL (with protocol)',
        :dragonfly_max_file_size => 'Max file size (in MB) for uploads',
        :api_public_key => 'The public API key for remote access to your Sapwood app',
        :google_analytics_id => 'If you want to track traffic on your builder',
        :mailer_sendgrid => 'Whether to use SendGrid to send emails',
        :mailer_user_name => 'Your SendGrid username',
        :mailer_password => 'Your SendGrid password',
        :mailer_domain => 'Your SendGrid domain',
        :mailer_address => 'Your SMTP address',
        :mailer_port => 'Your SMTP port',
        :mailer_default_from => 'The address from which emails originate',
        :notifications_errors_email_prefix => 'Prefix for email subject when sending error notifications',
        :notifications_errors_sender => 'The address from which to send emails when something goes wrong',
        :notifications_errors_recipient => 'The addresses of those who should receive emails when something goes wrong',
      }
    end
  end
end
