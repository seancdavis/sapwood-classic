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

  def viewer_main_nav(options = {})
    content_tag(:nav, :class => options[:nav_class]) do
      content_tag(:ul, :class => options[:ul_class]) do
        o = ''
        site_nav_pages.each do |page|
          path = is_home_page?(page) ? viewer_home : viewer_page(page.slug)
          active = (request.path.split('/').last == path.split('/').last)
          o += content_tag(
            :li,
            link_to(
              page.slug.gsub(/\_/, ' ').titleize,
              path,
              :class => "#{page.slug} #{'active' if active}"
            ),
            :class => page.slug
          )
        end
        o.html_safe
      end
    end
  end

  def viewer_menu(slug)
    menu = current_site.menus.find_by_slug(slug)
    if menu.nil?
      nil
    else
      content_tag(:nav) do
        content_tag(:ul) do
          o = ''
          menu.items.roots.each do |root|
            o += content_tag(:li) do
              o2 = link_to(
                root.title,
                root.page_id.blank? ? root.url : viewer_page(root.url)
              )
              nodes = root.subtree.arrange_serializable(:order => :position)
              if nodes.first["children"].size > 0
                o2 += viewer_submenu_collection(nodes.first["children"])
              end
              o2.html_safe
            end
          end
          o.html_safe
        end
      end
    end
  end

  def viewer_submenu_collection(items)
    content_tag(:ul) do
      o2 = ''
      items.each { |item| o2 += viewer_submenu_item(item) }
      o2.html_safe
    end
  end

  def viewer_submenu_item(item)
    item = OpenStruct.new(item)
    content_tag(:li) do
      o = link_to(
        item.title,
        item.page_id.blank? ? item.url : viewer_page(item.url)
      )
      if item.children.size > 0
        o += content_tag(:ul, viewer_submenu_collection(item.children))
      end
      o.html_safe
    end
  end

  def viewer_page_title(title, options = {})
    content_tag(:header, options[:header]) do
      content_tag(:h1) do
        content_tag(:span, title)
      end
    end
  end

  def viewer_image_path(filename)
    image_path "viewer/#{current_site.slug}/#{filename}"
  end

  def viewer_image(filename, options = {})
    image_tag "viewer/#{current_site.slug}/#{filename}", options
  end

  def main_header_image
    viewer_image('header.jpg')
  end

  def viewer_logo_image
    viewer_image('logo.png')
  end

  def slug_title(slug)
    slug.gsub(/\_/, ' ').humanize.titleize
  end

end
