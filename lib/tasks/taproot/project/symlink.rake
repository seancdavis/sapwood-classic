namespace :taproot do

  namespace :project do

    desc 'Create necessary symlinks for Taproot project'
    task :symlink, [:slug] => :environment do |t, args|

      # create references
      # 
      slug = args.slug
      underscore = "#{slug.underscore}"
      service = "#{underscore}_viewer.rb"
      project_dir = "#{Rails.root}/projects/#{slug}"

      # create symlinks
      # 
      {
        "images"                    => "app/assets/images/viewer/#{slug}",
        "javascripts"               => "app/assets/javascripts/viewer/#{slug}", 
        "services/#{service}"       => "app/viewer_services/#{service}", 
        "stylesheets"               => "app/assets/stylesheets/viewer/#{slug}", 
        "tasks/#{underscore}.rake"  => "lib/tasks/viewer/#{underscore}.rake", 
        "templates"                 => "app/views/viewer/#{slug}",
        "templates/layout.html.erb" => "app/views/layouts/viewer/#{slug}.html.erb"
      }.each do |source, dest|
        if File.exists?("#{Rails.root}/#{dest}")
          system("rm #{Rails.root}/#{dest}")
        end
        system("ln -s #{project_dir}/#{source} #{Rails.root}/#{dest}")
      end

    end

  end

end
