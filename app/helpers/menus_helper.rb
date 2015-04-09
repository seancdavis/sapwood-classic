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
    @current_menu_items ||= current_menu.items
  end

  def current_menu_item
    @current_menu_item ||= begin
      slug = params[:menu_item_slug] || params[:slug]
      current_menu_items.select { |e| e.slug == slug }.first
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
    if controller_name == 'items' && ['new', 'create'].include?(action_name)
      o += content_tag(:span, '/', :class => 'separator')
      o += link_to("new item", '#', :class => 'disabled')
    elsif current_menu_item && current_menu_item.id.present?
      o += content_tag(:span, '/', :class => 'separator')
      o += link_to(current_menu_item.slug, '#', :class => 'disabled')
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
        :title => "Menu Items",
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
