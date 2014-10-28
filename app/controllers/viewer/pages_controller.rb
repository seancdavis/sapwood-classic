class Viewer::PagesController < ViewerController

  def index
    @page = current_page_type; not_found if @page.nil?
    view = "viewer/#{current_site.slug}/#{current_page_type.slug}/index"
    render view, :layout => "#{current_site.slug}"
  end

  def show
    @page = current_page; not_found if @page.nil?
    view = "viewer/#{current_site.slug}/#{current_page_type.slug}/show"
    render view, :layout => "#{current_site.slug}"
  end

end
