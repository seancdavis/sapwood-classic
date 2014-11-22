class Api::V1::FormsController < ApplicationController

  include FormsHelper

  def create
    redirect_url = params[:form_submission][:redirect_url]
    if params[:key]
      @current_form = Form.find_by_key(params[:key])
      if current_form
        submission = FormSubmission.new(
          :form => current_form,
          :field_data => params[:form_submission][:field_data].to_hash
        )
        if submission.save
          redirect_to("#{redirect_url}?form=#{params[:key]}&result=success")
        else
          redirect_to("#{redirect_url}?form=#{params[:key]}&result=error")
        end
      else
        redirect_to(redirect_url)
      end
    else
      redirect_to(redirect_url)
    end
  end

  private

    def form_params
    end

end
