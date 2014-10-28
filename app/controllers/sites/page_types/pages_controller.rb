class Sites::PageTypes::PagesController < Sites::PageTypesController

  before_action :set_page

  def new
  end

  def create
    @page.save ? redirect_to(routes([current_page_type])[:show], 
      :notice => t('notices.created', 
      :item => controller_name.humanize.titleize)) : render('new')
  end

  private

    def set_page
      if action_name == 'new' || action_name == 'create'
        @page = Page.new(params[:page] ? create_params : nil)
      else
        @page = current_page_type.pages.where(:slug => params[:slug]).first
      end
      not_found if @page.nil?
    end

    def create_params
      params.require(:page).permit(:title, :description, :body, :published
      ).merge(
        :page_type => current_page_type,
      )
    end

end
