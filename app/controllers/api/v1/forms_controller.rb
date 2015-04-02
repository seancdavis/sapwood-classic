class Api::V1::FormsController < ApplicationController

  include FormsHelper

  def create
    redirect_url = params[:form_submission][:redirect_url]
    if params[:key]
      @current_form = Form.find_by_key(params[:key])
      if current_form

        field_data = params[:form_submission][:field_data].to_hash
        # Check for uploaded files
        files = []
        field_data.each do |k, v|
          if k.split('_').first.strip == 'rtfile'
            file = FormFile.create!(:file => v)
            files << file
            field_data[k] = file.id
          end
        end

        submission = FormSubmission.new(
          :form => current_form,
          :field_data => field_data
        )

        # Refer all uploaded files to this submission
        files.each { |file| file.update!(:form_submission => submission) }

        uri = URI::parse(redirect_url)
        query_string = ''
        unless uri.query.nil?
          query = uri.query.split('&')
          p = {}
          query.each do |param|
            q = param.split('=')
            p[q.first] = q.last unless ['form','result'].include?(q.first)
          end
          p.each { |k,v| query_string += "&#{k}=#{v}" }
        end

        if submission.save
          submission.send_notification
          redirect_to(
            "#{uri.path}?form=#{params[:key]}&result=success#{query_string}"
          )
        else
          redirect_to(
            "#{uri.path}?form=#{params[:key]}&result=error#{query_string}"
          )
        end
      else
        redirect_to(redirect_url)
      end
    else
      redirect_to(redirect_url)
    end
  end

end
