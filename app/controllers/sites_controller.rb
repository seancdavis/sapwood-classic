class SitesController < ApplicationController

  before_action :cache_user_state
  before_action :set_site

  include SitesHelper

  def index
    @sites = current_user.sites
    redirect_to last_site if @sites.size == 1
  end

  def show
  end

  def new
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

    def set_site
      slug = params[:site_slug] || params[:slug]
      if action_name == 'new' || action_name == 'create'
        @site = Heartwood::Site.new(params[:site] ? create_params : nil)
      else
        if admin?
          @site = Heartwood::Site.find_by_slug(slug)
        else
          @site = current_user.sites.where(:slug => slug).first
        end
      end
      not_found if @site.nil?
    end

    def create_params
      params.require(:site).permit(:title, :url, :description)
    end

    def update_params
      create_params
    end

end
