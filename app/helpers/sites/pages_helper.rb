module Sites
  module PagesHelper

    def current_page_type
      @current_page_type ||= begin
        p = params[:page_type_slug] || params[:slug]
        current_site.page_types.find_by_slug(p)
      end
    end

    def all_page_types
      @all_page_types ||= current_site.page_types
    end

    def has_page_type?
      all_page_types.size > 0
    end

    def page_type_field_options
      [
        ['Text (Single Line)', 'string'],
        ['Text (Editor)', 'text'],
        ['Dropdown', 'select'],
        ['Date', 'date'],
        ['Date & Time', 'datetime'],
        ['File Upload', 'file']
      ].sort
    end

    def field_groups
      current_page_type.groups
    end

    def available_page_type_children
      all_page_types - [current_page_type]
    end

  end
end
