class Sites::PageTypesController < SitesController

  def new
    @current_page_type = Heartwood::PageType.new
  end

  def create
    @current_page_type = Heartwood::PageType.new(create_params)
    if current_page_type.save
      delete_groups = params[:page_type][:delete_group].split(',').reject(&:blank?)
      if delete_groups.size > 0
        Heartwood::PageTypeFieldGroup.where(:slug => delete_groups).destroy_all
      end
      redirect_to(
        site_route([all_page_types], :index), 
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
    if current_page_type.update(update_params)
      delete_groups = params[:page_type][:delete_group].split(',').reject(&:blank?)
      if delete_groups.size > 0
        Heartwood::PageTypeFieldGroup.where(:slug => delete_groups).destroy_all
      end
      redirect_to(
        site_route([current_page_type], :edit), 
        :notice => t(
          'notices.updated', 
          :item => controller_name.humanize.titleize
        )
      )
    else
      render('edit')
    end
  end

  def destroy
    current_page_type.destroy
    redirect_to(
      site_route([all_page_types], :index), 
      :notice => t(
        'notices.deleted', 
        :item => controller_name.humanize.titleize
      )
    )
  end

  private

    def create_params
      params.require(:page_type).permit(
        :title, 
        :description, 
        :page_templates,
        :is_home,
        :label,
        :groups_attributes => [
          :id, 
          :title, 
          :position, 
          :fields_attributes => [
            :id, 
            :title, 
            :data_type, 
            :options, 
            :required, 
            :position
          ]
        ]
      ).merge(
        :site => current_site
      )
    end

    def update_params
      create_params
    end

end
