class Sites::PagesController < SitesController

  def new
    redirect_to current_site unless params[:page_type]
    @current_page_type = current_site.page_types.find_by_slug(params[:page_type])
    @current_page = Heartwood::Page.new
  end

  def create
    @current_page = Heartwood::Page.new(create_params)
    if current_page.save!
      redirect_to(
        site_route([current_page], :show), 
        :notice => t(
          'notices.created', 
          :item => controller_name.humanize.titleize
          )
      )
    else
      render('new')
    end
  end

  # def edit
  # end

  # def update
  #   if @page.update(create_params)
  #     # Expire Page
  #     expire_page(:controller => '/viewer/pages', :action => 'show', 
  #       :slug => @page.slug)
  #     # Download New Page
  #     system("curl #{page_url(current_site, current_page_type, @page)}")
  #     # Expire Page Typep
  #     expire_page(:controller => '/viewer/pages', :action => 'index', 
  #       :slug => current_page_type.slug)
  #     # Redirect
  #     redirect_to(routes([current_page_type])[:show],
  #       :notice => t('notices.updated', 
  #         :item => controller_name.humanize.titleize))
  #   else
  #     render('new')
  #   end
  # end

  # def destroy
  #   @page.destroy
  #   redirect_to(routes([current_page_type])[:show], 
  #     :notice => t('notices.updated', :item => 'Page'))
  # end

  private

    # def set_page_type
    # end

    def create_params
      @current_page_type = current_site.page_types.find_by_id(
        params[:page][:page_type_id]
      )
      fields = []
      current_page_type.groups.each { |g| fields << g.fields }
      fields = fields.flatten.uniq.collect(&:slug).map { |f| f.to_sym }
      params.require(:page).permit(
        :title, 
        :description, 
        :body, 
        :published,
        :template,
        :field_data => fields
      ).merge(
        :page_type => current_page_type,
      )
    end

end
