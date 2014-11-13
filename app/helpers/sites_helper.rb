module SitesHelper

  def current_site
    @current_site ||= begin
      p = params[:site_slug] || params[:slug]
      my_sites.select{ |s| s.slug == p }.first unless p.nil?
    end
  end

  def my_sites
    @my_sites ||= begin
      admin? ? Heartwood::Site.all : current_user.sites
    end
  end

  def has_multiple_sites?
    my_sites.size > 1
  end

  def only_site
    my_sites.first unless has_multiple_sites?
  end

  def site_list
    content_tag(:ul) do
      o = content_tag(:h2, 'Change Site')
      (current_user.sites - [current_site]).each do |site|
        o += content_tag(:li, link_to(site.title, site_path(site)))
      end
      o.html_safe
    end
  end

  def site_menu
    items = []
    current_site.page_types.each do |type|
      items << {
        'label' => type.title,
        'icon' => type.icon,
        'path' => site_page_type_path(current_site, type),
        'classes' => request.path.include?(
          site_page_type_path(current_site, type)) ? ' active' : nil
      }
    end
    items
  end

  def site_nav
    file = "#{Rails.root}/config/sites/site_nav.yml"
    return nil unless File.exists?(file)
    nav = YAML.load_file(file)
    nav.each do |item, attrs|
      nav[item]['path'] = send(nav[item]['path'], current_site)
      nav[item]['classes'] ||= ''
      if attrs['controllers'].include?(controller_name) || 
        request.path == nav[item]['path']
          nav[item]['classes'] += ' active'
      end
    end
  end

  def site_admin?(user = current_user)
    # site_users needs to be in memory
    su = user.site_users.select { |u| u.site_id = current_site.id }.first
    return su.site_admin? unless su.nil?
    false
  end

end
