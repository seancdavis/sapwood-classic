module ViewerHelper

  def viewer_service
    @viewer_service ||= "#{current_site.title.gsub(/\ /, '')}Viewer".constantize.new(current_site)
  end

  def meta_tag(content)
    content_tag(
      :meta, 
      nil, 
      :name => 'description', 
      :content => content
    ) unless content.blank?
  end

  def viewer_partial(name)
    render :partial => "viewer/#{current_site.slug}/#{name}"
  end

  def viewer_collection(collection, partial)
    render(
      :partial => "viewer/#{current_site.slug}/#{partial}", 
      :collection => collection
    )
  end

  def viewer_main_nav
    content_tag(:nav, :class => 'main') do
      content_tag(:ul) do
        o = ''
        site_root_pages.each do |page|
          o += content_tag(:li, link_to(
            page.title, 
            viewer_page(page.slug))
          )
        end
        o.html_safe
      end
    end
  end

  def viewer_page_title(title)
    content_tag(:header) do
      content_tag(:h1) do
        content_tag(:span, title)
      end
    end
  end

  def viewer_image(filename)
    image_tag "viewer/#{current_site.slug}/#{filename}"
  end

  def main_header_image
    viewer_image('header.jpg')
  end

  def viewer_logo_image
    viewer_image('logo.png')
  end

end
