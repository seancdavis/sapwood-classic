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

  def viewer_menu(slug, options = {})
    menu = current_site.menus.find_by_slug(slug)
    if menu.nil?
      nil
    else
      content_tag(:nav, options[:nav_html]) do
        content_tag(:ul, options[:ul_level_1]) do
          o = ''
          menu.items.roots.order('position asc').each do |root|
            o += content_tag(:li) do
              o2 = link_to(
                root.title,
                root.page_id.blank? ? root.url : viewer_page(root.url),
                :class => root.page_id.blank? ? 'disabled' : ''
              )
              nodes = root.subtree.arrange_serializable(:order => :position)
              if nodes.first["children"].size > 0
                o2 += viewer_submenu_collection(
                  nodes.first["children"], 2, options
                )
              end
              o2.html_safe
            end
          end
          o.html_safe
        end
      end
    end
  end

  def viewer_submenu_collection(items, level, options)
    content_tag(:ul, options[:"ul_level_#{level}"]) do
      o2 = ''
      items.sort_by { |i| i['position'] }.each do |item|
        o2 += viewer_submenu_item(item, level, options)
      end
      o2.html_safe
    end
  end

  def viewer_submenu_item(item, level, options)
    item = OpenStruct.new(item)
    content_tag(:li) do
      o = link_to(
        item.title,
        item.page_id.blank? ? item.url : viewer_page(item.url)
      )
      if item.children.size > 0
        o += viewer_submenu_collection(item.children, level + 1, options)
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

  def viewer_search_form(url = viewer_page('search'))
    simple_form_for(:search, :url => url, :method => :get) do |f|
      o = f.input :q, :label => false, :wrapper => false
      o += f.submit
    end
  end

  def viewer_search_results
    if params[:search] && params[:search][:q]
      results = current_site.pages.search_content(params[:search][:q]).to_a
    else
      []
    end
  end

  def viewer_paginated_search_results(per_page = 10)
    Kaminari.paginate_array(viewer_search_results).page(params[:page] || 1)
      .per(per_page)
  end

  def render_viewer_search_results(per_page = 10)
    if viewer_search_results.size > 0
      o = ''
      viewer_paginated_search_results(per_page).each do |page|
        o += content_tag(:div, :class => 'search-result') do
          o2 = content_tag(
            :h2,
            link_to(page.title, viewer_page(page.page_path))
          )
          o2 += simple_format(page.description) if page.description.present?
        end
      end
    else
      o = content_tag(
        :p,
        'There are no pages that match your search.',
        :class => 'no-results'
      )
    end
    o.html_safe
  end

end
