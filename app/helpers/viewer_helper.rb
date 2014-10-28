module ViewerHelper

  def current_site
    @current_site ||= Site.find_by_slug(params[:site_slug])
  end

  def current_page_type
    @current_page_type ||= begin
      slug = params[:page_type_slug] || params[:slug]
      PageType.find_by_slug(slug)
    end
  end

  def current_page
    @current_page ||= Page.find_by_slug(params[:slug])
  end

end
