class SitesController < ApplicationController

  before_filter :authenticate_admin!, :except => [:show]
  before_action :cache_user_state

  include SitesHelper

  def index
    @sites = current_user.sites
    redirect_to site_path(last_site) if @sites.size == 1
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
  end

  private

    def create_params
      params.require(:site).permit(:title, :url, :description)
    end

    def update_params
      create_params
    end

end
