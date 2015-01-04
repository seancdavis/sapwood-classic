module PageTypesHelper

  def site_page_types
    @site_page_types ||= current_site.page_types.alpha
  end

  def current_page_type
    @current_page_type ||= begin
      p = params[:page_type_slug] || params[:slug]
      current_site.page_types.find_by_slug(p)
    end
  end

  def has_page_type?
    site_page_types.size > 0
  end

  def page_type_children
    @page_type_children ||= begin
      children = current_page_type.children.reject(&:blank?)
      current_site.page_types.where(:slug => children)
    end
  end

  def page_type_groups
    @page_type_groups ||= current_page_type.groups
  end

  def page_type_tabs
    @page_type_tabs ||= page_type_groups.collect(&:slug)
  end

  def page_type_field_options
    [
      ['String', 'string'],
      ['Text', 'text'],
      ['Dropdown', 'select'],
      ['Date', 'date'],
      ['Checkbox', 'boolean'],
      ['Checkboxes', 'check_boxes'],
      ['Radio Buttons', 'radio_buttons'],
      # ['Date & Time', 'datetime'],
      ['File', 'file']
      # ['Image', 'image'],
    ]
  end

  def order_by_fields
    fields = []
    current_page_type.fields.each { |f| fields << [f.title, f.slug] }
    ([
      ['Title','title'],
      ['URL','slug'],
      ['Position','position'],
      ['Created','created_at'],
      ['Updated','updated_at'],
    ] + fields).uniq.sort
  end

end
