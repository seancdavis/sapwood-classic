class Sites::PageTypes::FieldsController < Sites::PageTypesController

  before_action :set_field

  def create
    @field.save ? redirect_to(routes([current_page_type])[:show], 
      :notice => t('notices.created', 
      :item => controller_name.humanize.titleize)) : render('new')
  end

  def update
    @field.update(update_params) ? redirect_to(routes([current_page_type])[:show], 
      :notice => t('notices.updated', 
      :item => controller_name.humanize.titleize)) : render('edit')
  end

  private

    def set_field
      if action_name == 'new' || action_name == 'create'
        @field = PageTypeField.new(params[:page_type_field] ? create_params : nil)
      else
        @field = current_page_type.where(:slug => params[:slug]).first
      end
      not_found if @field.nil?
    end

    def create_params
      params.require(:page_type_field).permit(:title, :data_type, :options, 
        :page_type_field_group_id)
    end

end
