module TemplatesHelper

  def site_templates
    @site_templates ||= current_site.templates.alpha
  end

  def current_template
    @current_template ||= begin
      if current_page.nil?
        p = params[:template_slug] || params[:slug]
        current_site.templates.find_by_slug(p)
      else
        current_page.template
      end
    end
  end

  def verify_current_template
    not_found if current_template.nil?
  end

  def current_template_pages
    @current_template_pages ||= current_template.webpages.alpha
  end

  def current_template_pages_paginated
    @current_template_pages_paginated ||= begin
      Kaminari.paginate_array(current_template_pages).page(params[:page]).per(10)
    end
  end

  def current_template_groups
    @current_template_groups ||= begin
      current_template.groups.in_order.includes(:template_fields)
    end
  end

  def current_template_group
    @current_template_group ||= begin
      current_template_groups.select { |g| g.slug == params[:slug] }.first
    end
  end

  def current_template_fields
    @current_template_fields ||= begin
      current_template.fields
    end
  end

  def current_template_field
    @current_template_field ||= begin
      slug = params[:template_field_slug] || params[:slug]
      current_template_fields.select { |f| f.slug == slug }.first
    end
  end

  def current_template_group_fields
    @current_template_group_fields ||= current_template_group.fields
  end

  def site_has_templates?
    site_templates.size > 0
  end

  def template_children
    @template_children ||= begin
      children = current_template.children.reject(&:blank?)
      site_templates.select { |t| children.include?(t.slug) }
    end
  end

  def template_field_options
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
    current_template.fields.each { |f| fields << [f.title, f.slug] }
    ([
      ['Title','title'],
      ['URL','slug'],
      ['Position','position'],
      ['Created','created_at'],
      ['Updated','updated_at'],
    ] + fields).uniq.sort
  end

  def current_template_actions
    s = current_site
    t = current_template
    [
      {
        :title => "#{current_template_pages.size} Pages",
        :path => builder_route([t, current_template_pages], :index),
        :class => 'pages'
      },
      {
        :title => 'Form Fields',
        :path => builder_route([t, t.fields], :index),
        :controllers => ['fields', 'groups'],
        :class => 'form'
      },
      {
        :title => 'Edit Template',
        :path => edit_builder_site_template_path(s, t),
        :class => 'edit'
      },
      {
        :title => 'Developer Help',
        :path => builder_route([t], :show),
        :class => 'help'
      }
    ]
  end

  def quick_template_status(template)
    if !template.limit_pages?
      link_to('', '#', :class => 'disabled unlimited')
    elsif template.maxed_out?
      link_to('', '#', :class => 'disabled maxed-out')
    else
      link_to('', '#', :class => 'disabled not-maxed')
    end
  end

  def template_status_filters
    o = link_to(
      "All",
      builder_site_templates_path(current_site, :tmpl_status => 'all'),
      :class => params[:tmpl_status] == 'all' ? 'active' : nil
    )
    o += link_to(
      "Unlimited",
      builder_site_templates_path(current_site, :tmpl_status => 'unlimited'),
      :class => "unlimited
        #{params[:tmpl_status] == 'unlimited' ? 'active' : nil}"
    )
    o += link_to(
      "Not Maxed",
      builder_site_templates_path(current_site, :tmpl_status => 'not_maxed'),
      :class => "not-maxed
        #{params[:tmpl_status] == 'not_maxed' ? 'active' : nil}"
    )
    o += link_to(
      "Maxed Out",
      builder_site_templates_path(current_site, :tmpl_status => 'maxed_out'),
      :class => "maxed-out
        #{params[:tmpl_status] == 'maxed_out' ? 'active' : nil}"
    )
    o.html_safe
  end

  def template_last_edited(template)
    date = template.updated_at.strftime("%h %d")
    if template.last_editor
      editor = " by #{content_tag(:span, template.last_editor.display_name)}"
    else
      editor = ''
    end
    content_tag(:span, :class => 'last-edited') do
      "Last edited #{content_tag(:span, date)}#{editor}".html_safe
    end
  end

  def quick_template_field_status(field)
    if field.protected?
      link_to('', '#', :class => 'disabled protected',
        :title => 'Protected')
    else
      link_to('', '#', :class => 'disabled unprotected',
        :title => 'Fully Editable')
    end
  end

  def current_template_breadcrumbs
    o = link_to("all templates", builder_route([current_template], :index))
    o += content_tag(:span, '/', :class => 'separator')
    if current_template.title.blank?
      o += link_to(
        "new",
        builder_route([current_template], :new)
      )
    else
      o += link_to(
        current_template.slug,
        builder_route([current_template], :show)
      )
    end
    if current_template_field
      o += content_tag(:span, '/', :class => 'separator')
      o += link_to(current_template_field.slug, '#', :class => 'disabled')
    end
    o.html_safe
  end

end
