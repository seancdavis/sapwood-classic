class Sites::PagesController < SitesController

  def show
    current_page
    unless page_type_children.size > 0
      redirect_to site_route([current_page], :edit)
    end
  end

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

  def update
    if current_page.update(update_params)
      redirect_to(site_route([current_page], :show),
        :notice => t(
          'notices.updated', 
          :item => controller_name.humanize.titleize
        )
      )
    else
      render('edit')
    end
  end

  # def destroy
  #   @page.destroy
  #   redirect_to(routes([current_page_type])[:show], 
  #     :notice => t('notices.updated', :item => 'Page'))
  # end

  private

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
        :position,
        :template,
        :field_data => fields
      ).merge(
        :page_type => current_page_type,
      )
    end

    def update_params
      fields = []
      current_page_type.groups.each { |g| fields << g.fields }
      fields = fields.flatten.uniq.collect(&:slug).map { |f| f.to_sym }
      params.require(:page).permit(
        :title, 
        :description, 
        :body, 
        :published,
        :position,
        :template,
        :field_data => fields
      )
    end

end
