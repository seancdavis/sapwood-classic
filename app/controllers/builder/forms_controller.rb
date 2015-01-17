class Builder::FormsController < BuilderController

  include FormsHelper

  def index
    if site_forms.size > 0
      path = builder_route([site_forms.first], :show)
    else
      path = builder_route([site_forms], :new)
    end
    redirect_to(path)
  end

  def show
    # unless current_form_submissions.size > 0
    #   redirect_to builder_route([current_form], :edit)
    # end
  end

  def new
    @current_form = Form.new
  end

  def create
    @current_form = Form.new(form_params)
    if current_form.save
      redirect_to builder_route([current_form], :index), 
        :notice => t('notices.created', :item => 'Form')
    else
      render 'new'
    end
  end

  def update
    if current_form.update(form_params)
      redirect_to builder_route([current_form], :edit), 
        :notice => t('notices.updated', :item => 'Form')
    else
      render 'edit'
    end
  end

  def destroy
    current_form.destroy
    redirect_to builder_route([site_forms], :index), 
      :notice => t('notices.deleted', :item => 'Form')
  end

  private

    def form_params
      params.require(:form).permit(
        :title,
        :button_label,
        :description,
        :body,
        :thank_you_body,
        :notification_emails,
        :form_fields_attributes => [
          :id,
          :title,
          :data_type,
          :position,
          :required,
          :options,
          :slug,
          :label,
          :placeholder,
          :default_value,
          :show_label,
        ]
      ).merge(
        :site => current_site
      )
    end

end
