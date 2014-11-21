class SitesController < ApplicationController

  layout :resolve_layout

  include Sites::PageTypesHelper, Sites::PagesHelper

  def index
    redirect_to(only_site) unless has_multiple_sites?
  end

  def show
  end

  def new
    @current_site = Heartwood::Site.new
  end

  def create
    @current_site = Heartwood::Site.new(create_params)
    if current_site.save
      Heartwood::SiteUser.create!(:user => current_user, :site => current_site, 
        :site_admin => true)
      redirect_to(route([current_site], :show), 
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
        :description,
        :home_page_id,
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
