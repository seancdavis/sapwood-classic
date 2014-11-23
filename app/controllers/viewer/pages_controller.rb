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
    not_found if current_page.nil?
    render(
      "viewer/#{current_site.slug}/#{current_page_template}", 
      :layout => current_site.slug
    )
  end

end
