class Viewer::PagesController < ViewerController

  # caches_page :index, :show

  def home
    @current_page = current_site.home_page
    show
  end

  def show
    if @current_page.nil?
      slug = params[:page_path].split('/').last
      @current_page = current_site.pages.find_by_slug(slug)
    end
    render(
      "viewer/#{current_site.slug}/#{template}", 
      :layout => current_site.slug
    )
  end

end
