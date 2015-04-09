module MenusHelper

  def site_menus
    @site_menus ||= current_site.menus.alpha
  end

  def current_menu
    @current_menu ||= begin
      slug = params[:menu_slug] || params[:slug]
      site_menus.select { |e| e.slug == slug }.first
    end
  end

  def current_menu_items
    @current_menu_items ||= begin
      if current_menu && current_menu.id.present?
        current_menu.items.in_position
      else
        nil
      end
    end
  end

  def current_menu_item_roots
    @current_menu_item_roots ||= current_menu_items.select(&:is_root?)
  end

  def current_menu_item
    @current_menu_item ||= begin
      if current_menu_items.nil?
        nil
      else
        slug = params[:menu_item_slug] || params[:slug]
        current_menu_items.select { |e| e.slug == slug }.first
      end
    end
  end

  def menus_breadcrumbs
    o = link_to("site menus", builder_route([site_menus], :index))
    if controller_name == 'menus' && ['new', 'create'].include?(action_name)
      o += content_tag(:span, '/', :class => 'separator')
      o += link_to("new menu", '#', :class => 'disabled')
    elsif current_menu && current_menu.id.present?
      o += content_tag(:span, '/', :class => 'separator')
      o += link_to(
        current_menu.slug,
        builder_route([current_menu, current_menu_items], :index)
      )
    end
    if current_menu_item
      if current_menu_item.id.present?
        current_menu_item.ancestors.each do |item|
          o += content_tag(:span, '/', :class => 'separator')
          o += link_to(item.slug, builder_route([current_menu, item], :show))
        end
        o += content_tag(:span, '/', :class => 'separator')
        o += link_to(
          current_menu_item.slug,
          builder_route([current_menu, current_menu_item], :show)
        )
      elsif params[:parent].present?
        item = current_menu_items.select { |i| i.slug == params[:parent] }.first
        item.ancestors.each do |item|
          o += content_tag(:span, '/', :class => 'separator')
          o += link_to(item.slug, builder_route([current_menu, item], :show))
        end
        o += content_tag(:span, '/', :class => 'separator')
        o += link_to(item.slug, builder_route([current_menu, item], :show))
      end
    end
    if controller_name == 'items' && ['new', 'create'].include?(action_name)
      o += content_tag(:span, '/', :class => 'separator')
      o += link_to("new item", '#', :class => 'disabled')
    end
    o.html_safe
  end

  def menu_last_updated(menu)
    date = menu.updated_at.strftime("%h %d")
    content_tag(:span, :class => 'last-edited') do
      "Last updated #{content_tag(:span, date)}".html_safe
    end
  end

  def current_menu_tabs
    s = current_site
    m = current_menu
    [
      {
        :title => "Build Menu",
        :path => builder_route([m, current_menu_items], :index),
        :class => 'menu',
        :controllers => ['items']
      },
      {
        :title => "Edit Menu",
        :path => builder_route([m], :edit),
        :class => 'edit'
      },
    ]
  end

end
