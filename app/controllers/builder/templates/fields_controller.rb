class Builder::Templates::FieldsController < BuilderController

  def index
  end

  def new
    @current_template_field = TemplateField.new
  end

  def create
    @current_template_field = TemplateField.new(field_params)
    if current_template_field.save
      redirect_to builder_route([t, t.fields], :index), :notice => 'Field saved!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      format.html do
        if current_template_field.update(field_params)
          redirect_to(
            builder_route([t, t.fields], :index), 
            :notice => 'Field saved!'
          )
        else
          render 'edit'
        end
      end
      format.json do 
        current_template_field.update!(field_params)
        render :nothing => true
      end
    end
  end

  def hide
    current_template_field.update!(:hidden => true)
    redirect_to(builder_route([t, t.fields], :index))
  end

  def show
    current_template_field.update!(:hidden => false)
    redirect_to(builder_route([t, t.fields], :index))
  end

  private

    def field_params
      params.require(:template_field).permit(
        :title, 
        :position,
        :template_group_id,
        :slug,
        :label,
        :data_type,
        :options,
        :required,
        :position,
        :hidden
      )
    end

    def t
      current_template
    end

end
