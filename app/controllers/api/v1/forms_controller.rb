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
