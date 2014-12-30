module NavHelper

  def read_nav_config(config)
    file = "#{Rails.root}/config/taproot/#{config}.yml"
    return nil unless File.exists?(file)
    nav = {}
    YAML.load_file(file).each { |k,v| nav[k] = v.to_ostruct }
    nav
  end

  def builder_site_nav_config
    read_nav_config('builder_site_nav')
  end

  def builder_site_nav
    content_tag(:ul) do
      items = ''
      builder_site_nav_config.each do |item, attrs|
        path = send(attrs.path, current_site)
        items += content_tag(
          :li,
          :class => builder_nav_active?(item, path, attrs.controllers) ? 'active' : nil
        ) do
          link_to(path) do
            content_tag(:i, nil, :class => "icon-#{attrs.icon}")
          end
        end
      end
      items.html_safe
    end
  end

  def builder_nav_active?(item, path, controllers = [])
    if controllers.include?(controller_name) || request.path == path
      @builder_nav_active_item = item
      true
    else
      false
    end
  end

  def builder_site_subnav
    @builder_site_subnav ||= begin
      begin
        items = send("builder_#{@builder_nav_active_item}_subnav")
      rescue
        return nil
      end

      content_tag(:ul) do
        output = ''
        items.each do |attrs|
          output += content_tag(:li, :class => attrs.classes) do
            m = attrs.request_type.blank? ? :get : attrs.request_type.to_sym
            if attrs.confirm.blank?
              link_to(attrs.label.upcase, attrs.path, :method => m)
            else
              link_to(
                attrs.label.upcase, 
                attrs.path, 
                :method => m,
                :data => { :confirm => attrs.confirm }
              )
            end
          end
        end
        output.html_safe
      end
    end
  end

  def builder_pages_subnav
    items = []
    site_root_pages.in_position.each do |page|
      items << {
        'label' => page.slug.gsub(/\_/, ' '),
        'path' => builder_route([page], :show),
        'classes' => (
          request.path.include?(
            builder_route([page], :show)
          ) || page == current_page_parent) && controller_name == 'pages' ? ' active' : nil
      }.to_ostruct
    end
    items
  end

  def builder_library_subnav
    items = [
      {
        'label' => 'All Files',
        'path' => builder_route([site_files], :index),
        'classes' => 'active'
      }.to_ostruct
    ]
  end

  def builder_forms_subnav
    items = []
    site_forms.each do |form|
      items << {
        'label' => form.slug.gsub(/\_/, ' '),
        'path' => builder_route([form], :edit),
        # 'classes' => (
        #   request.path.include?(
        #     builder_route([form], :show)
        #   ) || form == current_page_parent) && controller_name == 'pages' ? ' active' : nil
      }.to_ostruct
    end
    items
  end

  def builder_page_types_subnav
    items = []
    site_page_types.each do |page_type|
      path = builder_route([page_type], :edit)
      item = {
        'label' => page_type.title,
        'path' => path,
        'classes' => ''
      }
      if request.path == builder_route([page_type], :edit)
        item['classes'] = 'active'
      end
      items << item.to_ostruct
    end
    items
  end

  def builder_users_subnav
    items = []
    all_site_users.each do |user|
      path = builder_route([user], :edit)
      item = {
        'label' => user.display_name,
        'path' => path,
        'classes' => ''
      }
      if request.path == builder_route([user], :edit)
        item['classes'] = 'active'
      end
      items << item.to_ostruct
    end
    items
  end

  def builder_settings_subnav
    items = []
    read_nav_config('builder_settings_subnav').each do |item, attrs|
      if attrs.env.nil? || Rails.env.send("#{attrs.env}?")
        item = {
          'label' => attrs.label,
          'path' => send(attrs.path, current_site),
          'classes' => attrs.classes,
          'request_type' => attrs.request_type, 
        }
        item['confirm'] = attrs.confirm unless attrs.confirm.nil?
        items << item.to_ostruct
      end
    end
    items
  end

end
