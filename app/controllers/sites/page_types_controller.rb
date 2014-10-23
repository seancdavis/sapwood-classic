class Sites::PageTypesController < SitesController

  before_action :set_page_type

  def new
    @page_type = PageType.new
  end

  def create
    @page_type.save ? redirect_to(routes(@page_type)[:show], 
      :notice => t('notices.created', 
      :item => controller_name.humanize.titleize)) : render('new')
  end

  def update
    @page_type.update(update_params) ? redirect_to(routes(@page_type)[:show], 
      :notice => t('notices.updated', 
      :item => controller_name.humanize.titleize)) : render('edit')
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

end
