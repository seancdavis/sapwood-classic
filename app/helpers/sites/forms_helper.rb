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

    def form_field_options
      [
        ['Text (Single Line)', 'string'],
        ['Text (Multi-Line)', 'text'],
        ['Dropdown', 'select'],
        # ['Date', 'date'],
        # ['Date & Time', 'datetime'],
        # ['File Upload', 'file']
      ].sort
    end

  end
end
