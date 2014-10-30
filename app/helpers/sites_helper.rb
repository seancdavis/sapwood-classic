module SitesHelper

  include AccountsHelper, UsersHelper, ErrorsHelper

  def current_site
    @current_site ||= begin
      p = params[:site_slug] || params[:slug]
      if current_user.is_admin?
        site = Heartwood::Site.find_by_slug(p)
        return site unless site.nil?
        Heartwood::Site.first
      else
        current_user.sites.where(:slug => p).first
      end
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

  def site_route(items)
    i = "site_"; s = "site_"; pop = false
    if items.last.is_a?(Array)
      items[-1] = items.last.flatten.first
      pop = true
    end
    items.each do |item|
      klass = item.class.method_defined?(:model) ? item.model : item.class
      t = klass.table_name.gsub(/heartwood\_/, '')
      ts = t.singularize; s += "#{ts}_"
      item == items.last ? i += "#{t}_" : i += "#{ts}_"
    end
    objs = items.reverse.drop(1).reverse
    objs = objs.collect(&:to_param).join(',')
    if objs.empty?
      routes = {
        :index => send("#{i}path", current_site),
        :new => send("new_#{s}path", current_site),
        :edit => send("edit_#{s}path", current_site, items.last.to_param),
        :show => send("#{s}path", current_site, items.last.to_param)
      }
    else
      routes = {
        :index => send("#{i}path", current_site, objs),
        :new => send("new_#{s}path", current_site, objs),
        :edit => send("edit_#{s}path", current_site, objs, items.last.to_param),
        :show => send("#{s}path", current_site, objs, items.last.to_param)
      }
    end
  end

end
