module MenusHelper

  def site_menus
    @site_menus ||= current_site.menus.alpha
  end

  def current_menu
    @current_menu ||= begin
      slug = params[:slug] || params[:menu_slug]
      site_menus.select { |e| e.slug == slug }.first
    end
  end

  def menus_breadcrumbs
    o = link_to("site menus", builder_route([site_menus], :index))
    if controller_name == 'menus' && ['new', 'create'].include?(action_name)
      o += content_tag(:span, '/', :class => 'separator')
      o += link_to("new menu", '#', :class => 'disabled')
    end
    o.html_safe
  end

  def menu_last_updated(menu)
    date = menu.updated_at.strftime("%h %d")
    content_tag(:span, :class => 'last-edited') do
      "Last updated #{content_tag(:span, date)}".html_safe
    end
  end

end
