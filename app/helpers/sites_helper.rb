module SitesHelper

  include AccountsHelper

  def current_site
    @current_site ||= begin
      p = params[:site_slug] || params[:slug]
      site = current_user.sites.where(:slug => p).first
      return not_found if site.nil?
      site
    end
  end

  def nav
    file = "#{Rails.root}/config/sites/nav.yml"
    return nil unless File.exists?(file)
    nav = YAML.load_file(file)
    nav.each do |item, attrs|
      # create path
      nav[item]['path'] = send("sites_#{item}_path", current_site)
      # check for active class
      nav[item]['classes'] ||= ''
      if attrs['controllers'].include?(controller_name)
        nav[item]['classes'] += ' active'
      end
    end
  end

end
