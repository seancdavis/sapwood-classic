class Builder::Forms::FieldsController < BuilderController

  include FormsHelper

  def index
  end

  def update
    respond_to do |format|
      format.json do
        current_form_field.update!(position_params)
        render :nothing => true
      end
    end
  end

  private

    def position_params
      params.require(:form_field).permit(:position)
    end

end
