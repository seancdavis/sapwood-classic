module Sites
  module PageTypesHelper

    def all_page_types
      @all_page_types ||= current_site.page_types.alpha
    end

    def current_page_type
      @current_page_type ||= begin
        p = params[:page_type_slug] || params[:slug]
        current_site.page_types.find_by_slug(p)
      end
    end

    def has_page_type?
      all_page_types.size > 0
    end

    def page_type_children
      @page_type_children ||= begin
        children = current_page_type.children.reject(&:blank?)
        current_site.page_types.where(:slug => children)
      end
    end

    def page_type_field_options
      [
        ['String', 'string'],
        ['Text', 'text'],
        ['Dropdown', 'select'],
        # ['Date', 'date'],
        # ['Date & Time', 'datetime'],
        # ['File Upload', 'file']
        ['Image', 'image'],
      ]
    end

    def field_groups
      current_page_type.groups
    end

  end
end
