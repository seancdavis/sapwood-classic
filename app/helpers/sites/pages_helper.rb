module Sites
  module PagesHelper

    def current_page
      @current_page ||= begin
        p = params[:page_slug] || params[:slug]
        page = current_site.pages.find_by_slug(p)
        @current_page_type = page.page_type
        page
      end
    end

  end
end
