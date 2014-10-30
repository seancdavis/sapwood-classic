module SitesHelper

  include UsersHelper

  def current_site
    @current_site ||= begin
      p = params[:site_slug] || params[:slug]
      if admin?
        site = Heartwood::Site.find_by_slug(p)
        site = Heartwood::Site.first if site.nil?
      else
        site = current_user.sites.where(:slug => p).first
      end
      site
    end
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

  def site_nav
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

  def bottom_nav
    file = "#{Rails.root}/config/sites/nav.yml"
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
