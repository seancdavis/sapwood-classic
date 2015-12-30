class Viewer::PagesController < ViewerController

  before_filter :cors_check

  unless Rails.env.development?
    rescue_from ActionController::RoutingError do |e|
      error_404(e)
    end

    rescue_from URI::InvalidURIError do |e|
      error_404(e)
    end

    rescue_from ActionView::MissingTemplate do |e|
      error_500(e)
    end
  end

  def home
    @current_page = current_site.home_page
    if @current_page.nil? || (@current_page.draft? && Rails.env.production?)
      not_found
    else
      show
    end
  end

  def show
    if @current_page.nil?
      slug = params[:page_path].split('/').last
      @current_page = current_site.pages.find_by_slug(slug)
    end
    if current_page.nil?
      rt_slug = params[:page_path].split('/').first
      rt = current_site.resource_types.where(:slug => [
        rt_slug.singularize, rt_slug.pluralize
      ]).first
      if rt.nil? || !rt.has_show_view?
        not_found
      else
        @current_resource_type = rt
        if rt_slug == slug
          file = rt_slug.pluralize
        else
          file = rt_slug.singularize
          @current_resource = rt.resources.find_by_slug(slug)
        end
        render(
          "viewer/#{current_site.slug}/#{file}",
          :layout => @layout
        )
      end
    elsif current_template.has_show_view?
      resolve_layout
      render(
        "viewer/#{current_site.slug}/#{current_page_template}",
        :layout => @layout
      )
    else
      not_found
    end
  end

  private

    def error_404(error)
      if current_site && current_site.title.present?
        @q = request.path.split('/').last.humanize.split('.').first.downcase
        @results = current_site.pages.search_content(@q).to_a.first(10)
        dir = Rails.root.join('app', 'views', 'viewer', current_site.slug).to_s
        if(
          File.exists?("#{dir}/404.html.erb") ||
          File.exists?("#{dir}/404.html")
        )
          render(
            "viewer/#{current_site.slug}/404",
            :layout => false,
            :formats => [:html],
            :status => 404
          )
        else
          render 'previewer/404', :formats => [:html], :status => 404
        end
      else
        render :file => 'public/404.html', :status => 404
      end
    end

    def error_500(error)
      if current_site && current_site.title.present?
        dir = Rails.root.join('app', 'views', 'viewer', current_site.slug).to_s
        if(
          File.exists?("#{dir}/500.html.erb") ||
          File.exists?("#{dir}/500.html")
        )
          render(
            "viewer/#{current_site.slug}/500",
            :layout => false,
            :formats => [:html],
            :status => 500
          )
        else
          render 'previewer/500', :formats => [:html], :status => 500
        end
      else
        render 'previewer/500', :formats => [:html], :status => 500
      end
    end

    def resolve_layout
      if params[:layout] && params[:layout].to_bool == false
        @layout = false
      else
        @layout = "viewer/#{current_site.slug}"
      end
    end

    def cors_check
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

end
