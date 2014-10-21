module SitesHelper

  def current_site
    @current_site ||= begin
      p = params[:site_slug] || params[:slug]
      site = current_user.sites.where(:slug => p).first
      return not_found if site.nil?
      site
    end
  end

end
