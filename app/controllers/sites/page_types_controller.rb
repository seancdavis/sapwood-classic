class Sites::PageTypesController < SitesController

  include Sites::PagesHelper

  before_action :set_page_type

  def show
    @pages = @page_type.pages
  end

  def new
    @page_type = PageType.new
  end

  def create
    @page_type.save ? redirect_to(routes([@page_type])[:show], 
      :notice => t('notices.created', 
      :item => controller_name.humanize.titleize)) : render('new')
  end

  def edit
    @groups = @page_type.groups.in_order.includes(:fields)
  end

  def update
    if @page_type.update(update_params)
      delete_groups = params[:page_type][:delete_group].split(',').reject(&:blank?)
      if delete_groups.size > 0
        PageTypeFieldGroup.where(:slug => delete_groups).destroy_all
      end
      redirect_to(routes([@page_type])[:edit], :notice => t('notices.updated', 
        :item => controller_name.humanize.titleize))
    else
      render('edit')
    end
  end

  private

    def set_page_type
      if action_name == 'new' || action_name == 'create'
        @page_type = PageType.new(params[:page_type] ? create_params : nil)
      else
        @page_type = current_site.page_types.where(:slug => params[:slug]).first
      end
      not_found if @page_type.nil?
    end

    def create_params
      params.require(:page_type).permit(:title, :description, :icon, 
        :template).merge(:site => current_site)
    end

    def update_params
      params.require(:page_type).permit(
        :title, :description, :icon, :template,
        :groups_attributes => [:id, :title, :position, 
          :fields_attributes => [:id, :title, :data_type, :options, :required, 
            :position]
        ]
      ).merge(:site => current_site)
    end

end
