module ResourcesHelper

  def site_resource_types
    @site_resource_types ||= begin
      current_site.resource_types.includes(:last_editor, :resources).alpha
    end
  end

  def current_resource_type
    @current_resource_type ||= begin
      p = params[:resource_type_slug] || params[:slug]
      site_resource_types.select { |r| r.slug == p }.first
    end
  end

  def verify_current_resource_type
    not_found if current_resource_type.nil?
  end

  def current_resources
    @current_resources ||= current_resource_type.resources
  end

  def current_resource
    @current_resource ||= begin
      p = params[:resource_slug] || params[:slug]
      current_resources.select { |r| r.slug == p }.first
    end
  end

  def current_resource_fields
    @current_resource_fields ||= current_resource_type.fields.in_position
  end

  def current_resource_association_fields
    @current_resource_association_fields ||= begin
      current_resource_type.association_fields.in_position
    end
  end

  def current_resource_field
    @current_resource_field ||= begin
      slug = params[:resource_field_slug] || params[:slug]
      current_resource_fields.select { |f| f.slug == slug }.first
    end
  end

  def current_resource_association_field
    @current_resource_association_field ||= begin
      slug = params[:resource_association_field_slug] || params[:slug]
      current_resource_association_fields.select { |f| f.slug == slug }.first
    end
  end

  def resource_field_options
    [
      ['String', 'string'],
      ['Text', 'text'],
      ['Dropdown', 'select'],
      ['Date', 'date'],
      ['Checkbox', 'boolean'],
      ['Checkboxes', 'check_boxes'],
      ['Radio Buttons', 'radio_buttons'],
      # ['Date & Time', 'datetime'],
      # ['File', 'file']
      # ['Image', 'image'],
    ]
  end

  def current_resource_actions
    s = current_site
    rt = current_resource_type
    f = current_resource_fields
    af = current_resource_association_fields
    [
      {
        :title => current_resource_type.title.pluralize,
        :path => builder_route([rt, current_resources], :index),
        :controllers => ['items'],
        :class => 'pages'
      },
      {
        :title => 'Resource Fields',
        :path => builder_route([rt, f], :index),
        :controllers => ['fields'],
        :class => 'form'
      },
      {
        :title => 'Association Fields',
        :path => builder_route([rt, af], :index),
        :controllers => ['association_fields'],
        :class => 'form'
      },
      {
        :title => 'Edit Resource Type',
        :path => builder_route([rt], :edit),
        :class => 'edit'
      },
      # {
      #   :title => 'Developer Help',
      #   :path => builder_route([t], :show),
      #   :class => 'help'
      # }
    ]
  end

  def resource_order_by_fields
    fields = []
    # current_resource_type.fields.each { |f| fields << [f.title, f.slug] }
    ([
      ['Title','title'],
      ['URL','slug'],
      ['Position','position'],
      ['Created','created_at'],
      ['Updated','updated_at'],
    ] + fields).uniq.sort
  end

  def resource_type_last_edited(resource_type)
    date = resource_type.updated_at.strftime("%h %d")
    if resource_type.last_editor
      editor  = " by "
      editor += content_tag(:span, resource_type.last_editor.display_name)
    else
      editor = ''
    end
    content_tag(:span, :class => 'last-edited') do
      "Last edited #{content_tag(:span, date)}#{editor}".html_safe
    end
  end

  def current_resource_breadcrumbs
    o = link_to("resource types", builder_route([site_resource_types], :index))
    if current_resource_type
      o += content_tag(:span, '/', :class => 'separator')
      if current_resource_type.title.blank?
        o += link_to(
          "new",
          builder_route([current_resource_type], :new)
        )
      else
        o += link_to(
          current_resource_type.slug,
          builder_route([current_resource_type], :show)
        )
      end
      if current_resource_field
        if action_name == 'new'
          o += content_tag(:span, '/', :class => 'separator')
          o += link_to("new field", '#', :class => 'disabled')
        else
          o += content_tag(:span, '/', :class => 'separator')
          o += link_to(current_resource_field.slug, '#', :class => 'disabled')
        end
      end
    end
    o.html_safe
  end

end
