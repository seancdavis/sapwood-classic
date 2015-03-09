class Builder::SubmissionsController < BuilderController

  include FormsHelper

  def show
  end

  private

    def builder_html_title
      @builder_html_title ||= begin
        "#{current_form_submission.field_data.first.last} >> #{current_form.title}"
      end
    end

end
