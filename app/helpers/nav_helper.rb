module NavHelper

  def builder_site_nav_config
    file = "#{Rails.root}/config/taproot/builder_site_nav.yml"
    return nil unless File.exists?(file)
    nav = {}
    YAML.load_file(file).each { |k,v| nav[k] = v.to_ostruct }
    nav
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
            link_to(attrs.label.upcase, attrs.path)
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

end
