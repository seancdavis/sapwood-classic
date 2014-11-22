module ViewerHelper

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def all_sites
    @all_sites ||= Site.all
  end

  def first_site
    @first_site ||= Site.order('created_at asc').limit(1).first
  end

  def current_site
    @current_site ||= Site.find_by_slug(params[:site_slug])
  end

  def service
    @service ||= current_site.title.gsub(/\ /, '').constantize.new(current_site)
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

  def site_pages
    @site_pages ||= begin
      current_site.pages.roots.published.in_position
    end
  end

  def template
    @template ||= current_page.template
  end

  def meta(content)
    content_tag(
      :meta, 
      nil, 
      :name => 'description', 
      :content => content
    ) unless content.blank?
  end

  def partial(name)
    render :partial => "viewer/#{current_site.slug}/#{name}"
  end

  def collection(collection, partial)
    render(
      :partial => "viewer/#{current_site.slug}/#{partial}", 
      :collection => collection
    )
  end

  def setting
    SETTINGS.send(current_site.slug.underscore)
  end

  def main_nav
    content_tag(:nav, :class => 'main') do
      content_tag(:ul) do
        o = ''
        site_pages.each do |page|
          o += content_tag(:li, link_to(
            page.title, 
            viewer_page_path(:page_path => page.slug))
          )
        end
        o.html_safe
      end
    end
  end

  def page_title(title)
    content_tag(:header) do
      content_tag(:h1) do
        content_tag(:span, title)
      end
    end
  end

  def image(filename)
    image_tag "#{current_site.slug}/#{filename}"
  end

  def main_header_image
    image('header.jpg')
  end

  def logo_image
    image('logo.png')
  end

end
