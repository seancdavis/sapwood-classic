module SitesHelper

  include AccountsHelper, UsersHelper

  def current_site
    @current_site ||= begin
      p = params[:site_slug] || params[:slug]
      if current_user.is_admin?
        Site.find_by_slug(p)
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

  def nav
    file = "#{Rails.root}/config/sites/nav.yml"
    return nil unless File.exists?(file)
    nav = YAML.load_file(file)
    nav.each do |item, attrs|
      # create path
      nav[item]['path'] = send("site_#{item}_path", current_site)
      # check for active class
      nav[item]['classes'] ||= ''
      if attrs['controllers'].include?(controller_name)
        nav[item]['classes'] += ' active'
      end
    end
  end

  def routes
    {
      :index => send("site_#{controller_name}_path", current_site),
      :new => send("new_site_#{controller_name.singularize}_path", current_site),
    }
  end

end
