module SitesHelper

  def current_site
    @current_site ||= begin
      if ['localhost','cms.rocktree.us'].include?(request.domain)
        p = params[:site_slug] || params[:slug]
        if user_signed_in?
          my_sites.select{ |s| s.slug == p }.first unless p.nil?
        else
          Site.find_by_slug(p) unless p.nil?
        end
      else
        Site.find_by_url(request.domain)
      end
    end
  end

  def my_sites
    @my_sites ||= begin
      admin? ? Site.last_updated : current_user.sites.last_updated
    end
  end

  def has_sites?
    my_sites.size > 0
  end

  def has_multiple_sites?
    my_sites.size > 1
  end

  def only_site
    my_sites.first unless has_multiple_sites?
  end

  def site_setting
    SETTINGS.send(current_site.slug.underscore)
  end

  def builder_site_menu
    items = []
    site_root_pages.in_position.each do |page|
      items << {
        'label' => page.title,
        'path' => builder_route([page], :show),
        'classes' => (
          request.path.include?(
            builder_route([page], :show)
          ) || page == current_page_parent) && controller_name == 'pages' ? ' active' : nil
      }
    end
    items
  end

  def builder_site_nav
    file = "#{Rails.root}/config/sites/builder_site_nav.yml"
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

end
