class Builder::TemplatesController < BuilderController

  def index
    @templates = site_templates
    if params[:tmpl_status] && params[:tmpl_status] != 'all'
      @templates = @templates.select { |t| t.send("#{params[:tmpl_status]}?") }
    elsif params[:tmpl_status] != 'all'
      redirect_to(
        builder_site_templates_path(current_site, :tmpl_status => 'all')
      )
    end
  end

  def show
  end

  def new
    @current_template = Template.new
  end

  def create
    @current_template = Template.new(create_params)
    if current_template.save
      redirect_to(
        builder_site_template_dev_settings_path(current_site, current_template), 
        :notice => 'Template created! Now, add your developer settings.'
      )
    else
      render 'new'
    end
  end

  def edit
    form = request.path.split('/').last
    if form == 'edit'
      redirect_to(
        builder_site_template_settings_path(current_site, current_template)
      )
    else
      render request.path.split('/').last
    end
  end

  def update
    if current_template.update(update_params)
      if redirect_route.split('/').last == 'dev_settings'
        redirect_to(
          builder_site_template_dev_settings_path(
            current_site, 
            current_template
          ), 
          :notice => 'Template saved!'
        )
      else
        redirect_to(redirect_route, :notice => 'Template saved!')
      end
    else
      params[:redirect_route] = redirect_route
      render redirect_route.split('/').last
    end
  end

  def destroy
    if current_template.deletable?
      current_template.destroy
      redirect_to builder_route([site_templates], :index), 
        :notice => 'Template deleted successfully!'
    else
      redirect_to builder_route([site_templates], :index), 
        :alert => 'You are not allowed to delete a template with pages.'
    end
  end

  private

    def create_params
      params.require(:template).permit(:title, :description)
        .merge(:site => current_site, :last_editor => current_user)
    end

    def update_params
      params.require(:template).permit(
        # Template Settings
        :title, 
        :description,
        # Developer Settings
        :slug,
        :can_be_root,
        :order_method,
        :order_direction,
        :limit_pages,
        :max_pages,
        :children => [],
      ).merge(:last_editor => current_user)
    end

    def redirect_route
      params[:template][:redirect_route]
    end

end
