class SitesController < ApplicationController

  before_filter :authenticate_admin!, :except => [:show]
  before_action :cache_user_state

  layout :resolve_layout

  include Sites::PagesHelper

  def index
    @sites = current_user.sites
    redirect_to(only_site) unless has_multiple_sites?
  end

  def show
    if has_page_type?
      redirect_to(site_route([all_page_types.first], :show))
    else
      redirect_to(site_route([all_page_types], :new))
    end
  end

  def new
    @site = Heartwood::Site.new
  end

  def create
    @site = Heartwood::Site.new(create_params)
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
      redirect_to(route([current_site], :edit), 
        :notice => t('notices.updated', :item => "Site")) 
    else
      render('edit')
    end
  end

  private

    def create_params
      params.require(:site).permit(
        :title, 
        :url, 
        :description
      )
    end

    def update_params
      create_params
    end

    def resolve_layout
      if controller_name == 'sites'
        case action_name
        when 'index', 'new', 'create'
          'my_sites'
        else
          'application'
        end
      end
    end

end
