class SitesController < ApplicationController

  before_filter :authenticate_admin!, :except => [:show]
  before_action :cache_user_state

  def index
    @sites = current_user.sites
    has_multiple_sites? ? render(:layout => 'my_sites') : redirect_to(only_site)
  end

  def show
  end

  def new
    @site = Heartwood::Site.new
  end

  def create
    if @site.save
      Heartwood::SiteUser.create!(:user => current_user, :site => @site, 
        :site_admin => true)
      redirect_to(route([@site], :show), 
        :notice => t('notices.created', :item => "Site")) 
    else
      render('new')
    end
  end

  def edit
    @site = current_site
  end

  def update
    if current_site.update(update_params)
      redirect_to(route([current_site], :show), 
        :notice => t('notices.updated', :item => "Site")) 
    else
      render('edit')
    end
  end

  private

    def create_params
      params.require(:site).permit(:title, :url, :description)
    end

    def update_params
      create_params
    end

end
