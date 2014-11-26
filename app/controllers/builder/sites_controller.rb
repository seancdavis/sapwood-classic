class Builder::SitesController < BuilderController

  before_filter :set_layout_options

  def index
  end

  def show
  end

  def new
    @current_site = Site.new
  end

  def create
    @current_site = Site.new(create_params)
    if current_site.save
      SiteUser.create!(:user => current_user, :site => current_site, 
        :site_admin => true)
      redirect_to(route([current_site], :show, 'builder'), 
        :notice => t('notices.created', :item => "Site")) 
    else
      render('new')
    end
  end

  def edit
    current_site = current_site
  end

  def update
    if current_site.update(update_params)
      redirect_to(route([current_site], :edit, 'builder'), 
        :notice => t('notices.updated', :item => "Site")) 
    else
      render('edit')
    end
  end

  def git
    local_repo = current_site.local_repo
    if local_repo.present? && Dir.exists?(local_repo)
      system("cd #{local_repo}; git checkout master")
      system("cd #{local_repo}; git pull origin master")
      ['images', 'stylesheets', 'javascripts'].each do |asset| 
        system("rm app/assets/#{asset}/viewer/#{current_site.slug}")
        system("ln -s #{local_repo}/#{asset} app/assets/#{asset}/viewer/#{current_site.slug}")
      end
      service = "#{current_site.slug.underscore}_viewer.rb"
      system("rm app/services/#{service}")
      system("ln -s #{local_repo}/services/#{service} app/services/#{service}")
      system("rm app/views/layouts/viewer/#{current_site.slug}.html.erb")
      system("ln -s #{local_repo}/templates/layout.html.erb app/views/layouts/viewer/#{current_site.slug}.html.erb")
      system("rm app/views/viewer/#{current_site.slug}")
      system("ln -s #{local_repo}/templates app/views/viewer/#{current_site.slug}")
      system("RAILS_ENV=#{Rails.env} bundle exec rake assets:precompile")
      redirect_to request.referrer, :notice => 'Git updated successfully.'
    else
      redirect_to request.referrer, :notice => 'There was a problem.'
    end
  end

  private

    def create_params
      params.require(:site).permit(
        :title, 
        :url, 
        :description,
        :home_page_id,
        :git_url,
        :local_repo,
        :image_croppings_attributes => [
          :id, 
          :title,
          :ratio,
          :min_width,
          :min_height
        ]
      )
    end

    def update_params
      create_params
    end

    def set_layout_options
      if ['index', 'new', 'create'].include?(action_name)
        @options['sidebar'] = false
        @options['body_classes'] += ' my-sites'
      end
    end

end
