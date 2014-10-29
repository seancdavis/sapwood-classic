class Sites::PageTypes::PagesController < Sites::PageTypesController

  before_action :set_page

  def new
  end

  def create
    @page.save ? redirect_to(routes([current_page_type])[:show], 
      :notice => t('notices.created', 
      :item => controller_name.humanize.titleize)) : render('new')
  end

  def edit
  end

  def update
    if @page.update(create_params)
      # Expire Page
      expire_page(:controller => '/viewer/pages', :action => 'show', 
        :slug => @page.slug)
      # Download New Page
      system("curl #{page_url(current_site, current_page_type, @page)}")
      # Expire Page Typep
      expire_page(:controller => '/viewer/pages', :action => 'index', 
        :slug => current_page_type.slug)
      # Redirect
      redirect_to(routes([current_page_type])[:show],
        :notice => t('notices.updated', 
          :item => controller_name.humanize.titleize))
    else
      render('new')
    end
  end

  def destroy
    @page.destroy
    redirect_to(routes([current_page_type])[:show], 
      :notice => t('notices.updated', :item => 'Page'))
  end

  private

    def set_page_type
    end

    def set_page
      @groups = current_page_type.groups.includes(:fields)
      if action_name == 'new' || action_name == 'create'
        @page = Page.new(params[:page] ? create_params : nil)
      else
        @page = current_page_type.pages.where(:slug => params[:slug]).first
      end
      not_found if @page.nil?
    end

    def create_params
      fields = []; @groups.each { |g| fields << g.fields }
      fields = fields.flatten.uniq.collect(&:slug).map { |f| f.to_sym }
      params.require(:page).permit(:title, :description, :body, :published,
        :field_data => fields
      ).merge(
        :page_type => current_page_type,
      )
    end

end
