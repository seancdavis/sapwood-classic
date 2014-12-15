require 'fileutils'
require 'uri'

class TaprootProject

  def initialize(site = nil)
    @site = site unless site.nil?
  end

  # ------------------------------------------ Grouped Actions

  def create_site
    verify_site
    create_default_site_files
    remove_bad_symlinks
    create_symlinks
    git_init
    git_push
  end

  def import_site
    verify_site
    git_clone
    remove_bad_symlinks
    create_symlinks
  end

  def update_symlinks
    verify_site
    remove_bad_symlinks
    create_symlinks
  end

  # ------------------------------------------ Individual Actions

  def add_to_database(name, git_path)
    @site = Site.create!(
      :title => name,
      :git_path => git_path
    )
  end

  def create_default_site_files
    verify_site
    FileUtils.cp_r(default_project_dir, project_dir)
    Dir.glob("#{project_dir}/**/*", File::FNM_DOTMATCH).each do |file|
      if File.file?(file)
        content = File.read(file)
        content = content.gsub(/default\-site/, project_slug)
        content = content.gsub(/default\_site/, project_class_file)
        content = content.gsub(/DefaultSite/, project_class)
        File.open(file, 'w+') { |f| f << content }
      end
    end
  end

  def git_init
    verify_site
    verify_directory
    system("cd #{project_dir}; git init")
    system("cd #{project_dir}; git remote add origin #{git_url}")
    system("cd #{project_dir}; git add .")
    system("cd #{project_dir}; git commit -am 'init commit'")
  end

  def git_push
    verify_site
    verify_directory
    system("cd #{project_dir}; git checkout master; git pull origin master")
    system("cd #{project_dir}; git push origin master")
  end

  def git_clone
    verify_site
    verify_no_directory
    system("cd #{projects_dir}; git clone #{git_url} #{project_slug}")
    system("cd #{Rails.root}")
  end

  def create_symlinks
    verify_site
    Dir.glob("#{project_dir}/**/*", File::FNM_DOTMATCH).each do |file|
      unless file.split('/').include?('.git')
        if File.file?(file)
          filename = file.split('/').last
          if filename == '.symlink'
            dest = File.read(file).strip #.split('/')[0..-2].join('/')
            src = file.split('/')[0..-2].join('/')
            if File.exists?(dest)
              FileUtils.rm(dest)
            end
            create_parent_directories(dest)
            system("ln -s #{src} #{dest}")
          elsif file.text?
            symlink = File.read(file).match(/rtsym\:(.*)[\n|\ ]/)
            unless symlink.nil?
              dest = symlink.to_s.gsub(/rtsym\:/, '').strip.split(' ').first
              if File.exists?(dest)
                FileUtils.rm(dest)
              end
              create_parent_directories(dest)
              system("ln -s #{file} #{dest}")
            end
          end
        end
      end
    end
  end

  def create_parent_directories(path)
    FileUtils.mkdir_p(path.split('/')[0..-2].join('/'))
  end

  def remove_files
    verify_site
    if Dir.exists?(project_dir)
      FileUtils.rm_r(project_dir)
    end
    remove_bad_symlinks
  end

  def remove_bad_symlinks
    system("find #{Rails.root} -type l -exec sh -c \"file -b {} | grep -q ^broken\" \\; -delete")
  end

  private

    # ------------------------------------------ Verification

    def verify_site
      if @site.nil?
        raise "Need to load a site first."
      end
    end

    def verify_directory
      unless Dir.exists?(project_dir)
        raise "Directory does not exist: #{project_dir}"
      end
    end

    def verify_no_directory
      if Dir.exists?(project_dir)
        raise "Directory already exists: #{project_dir}"
      end
    end

    # ------------------------------------------ References

    def projects_dir
      "#{Rails.root}/projects"
    end

    def project_dir
      "#{projects_dir}/#{project_slug}"
    end

    def default_project_dir
      "#{projects_dir}/.default-site"
    end

    def project_slug
      @site.slug
    end

    def project_class_file
      @site.class_file
    end

    def project_class
      @site.title.titleize.gsub(/\ /, '')
    end

    def git_url
      t = TaprootSetting
      username = URI.escape(t.git.username, "!?='^")
      password = URI.escape(t.git.password, "!?='^")
      o =  "#{t.git.protocol}://#{username}:#{password}"
      o += "@#{t.git.url}/#{@site.git_path}.git"
    end

end
