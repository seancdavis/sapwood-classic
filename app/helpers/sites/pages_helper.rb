module Sites
  module PagesHelper

    def current_page
      @current_page ||= begin
        p = params[:page_slug] || params[:slug]
        current_site.pages.find_by_slug(p)
      end
    end

  end
end
