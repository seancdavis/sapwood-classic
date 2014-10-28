class Viewer::PagesController < ViewerController

  def show
    @page = current_page; not_found if @page.nil?
    view = "viewer/#{current_site.slug}/#{current_page_type.slug}/show"
    render view, :layout => "#{current_site.slug}"
  end

end
