require 'fileutils'

namespace :taproot do

  namespace :project do

    desc "Remove a Taproot project and its symlinks (doesn't delete project)"
    task :remove, [:slug] => :environment do |t, args|

      # create references
      # 
      slug = args.slug
      underscore = "#{slug.underscore}"
      service = "#{underscore}_viewer.rb"
      project_dir = "#{Rails.root}/projects/#{slug}"

      # remove symlinks
      # 
      [
        "app/assets/images/viewer/#{slug}",
        "app/assets/javascripts/viewer/#{slug}", 
        "app/viewer_services/#{service}", 
        "app/assets/stylesheets/viewer/#{slug}", 
        "lib/tasks/viewer/#{underscore}.rake", 
        "app/views/viewer/#{slug}",
        "app/views/layouts/viewer/#{slug}.html.erb"
      ].each do |symlink|
        if File.exists?("#{Rails.root}/#{symlink}")
          FileUtils.rm("#{Rails.root}/#{symlink}") 
        end
      end

      # remove project files
      # 
      FileUtils.rm_r(project_dir)

    end

  end

end
