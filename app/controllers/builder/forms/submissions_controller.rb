class Builder::Forms::SubmissionsController < BuilderController

  include FormsHelper

  def index
  end

  def show
  end

  private

    def builder_html_title
      @builder_html_title ||= begin
        if current_form_submission
          t = current_form_submission.field_data.first.last
          t += " >> #{current_form.title}"
        else
          "Submissions >> #{current_form.title}"
        end
      end
    end

end
