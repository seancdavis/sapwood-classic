module Sites
  module FormsHelper

    def site_forms
      @site_forms ||= current_site.forms
    end

    def current_form
      @current_form ||= begin
        p = params[:form_slug] || params[:slug]
        current_site.forms.find_by_slug(p)
      end
    end

  end
end
