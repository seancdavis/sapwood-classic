class Sites::PageTypes::GroupsController < Sites::PageTypesController

  before_action :set_group

  def create
    @group.save ? redirect_to(routes([current_page_type])[:show], 
      :notice => t('notices.created', 
      :item => controller_name.humanize.titleize)) : render('new')
  end

  def update
    @group.update(update_params) ? redirect_to(routes([current_page_type])[:show], 
      :notice => t('notices.updated', 
      :item => controller_name.humanize.titleize)) : render('edit')
  end

  private

    def set_group
      if action_name == 'new' || action_name == 'create'
        @group = PageTypeFieldGroup.new(
          params[:page_type_field_group] ? create_params : nil)
      else
        @group = current_page_type.where(:slug => params[:slug]).first
      end
      not_found if @group.nil?
    end

    def create_params
      params.require(:page_type_field_group).permit(:title, :position).merge(
        :page_type => current_page_type)
    end

end
