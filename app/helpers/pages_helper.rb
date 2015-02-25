module PagesHelper

  def site_pages
    @site_pages ||= current_site.webpages
  end

  def site_root_pages
    @site_root_pages ||= site_pages.roots.in_position
  end

  def site_nav_pages
    @site_nav_pages ||= site_root_pages.select(&:show_in_nav?)
  end

  def site_floating_root_pages
    @site_floating_root_pages ||= site_root_pages.select { |p| !p.show_in_nav? }
  end

  def current_page
    @current_page ||= begin
      if controller_name == 'pages' || controller_name == 'editor'
        p = params[:page_slug] || params[:slug]
        page = current_site.webpages.find_by_slug(p)
        return nil if page.nil?
        page
      else
        nil
      end
    end
  end

  def current_page_template
    @current_page_template ||= current_template.filename
  end

  def current_page_template_class
    slug = @current_page_template
    slug = "_#{slug}" if slug[0] =~ /[0-9]/
    slug
  end

  def current_page_parent
    @current_page_parent ||= begin
      if params[:parent]
        current_site.pages.find_by_slug(params[:parent])
      else
        current_page_ancestors.last
      end
    end
  end

  def current_page_ancestors
    @current_page_ancestors ||= current_page.ancestors
  end

  def has_ancestors?
    @has_ancestors ||= current_page && current_page_ancestors.size > 0
  end

  def current_page_children
    @current_page_children ||= current_page.children.in_position.includes(:template)
  end

  def current_page_children_paginated
    @current_page_children_paginated ||= begin
      current_page_children.page(params[:page]).per(10)
    end
  end

  def current_page_children_filtered
    @current_page_children_filtered ||= begin
      template = current_site.templates
        .find_by_slug(params[:template_slug] || params[:slug])
      current_page_children.select { |p| p.template == template }
    end
  end

  def current_page_children_filtered_paginated
    @current_page_children_filtered_paginated ||= begin
      Kaminari.paginate_array(current_page_children_filtered)
        .page(params[:page]).per(10)
    end
  end

  def paginate_links(collection, controller, action)
    paginate(
      collection, 
      # :remote => true, 
      :params => { 
        :controller => controller, 
        :action => action, 
        :_ => nil, 
        :_method => nil, 
        :authenticity_token => nil, 
        :store => nil, 
        :commit => nil, 
        :utf8 => nil
      }
    )
  end

  def current_page_breadcrumbs
    content_tag(:nav, :class => 'breadcrumbs') do
      content_tag(:ul) do
        o = content_tag(
          :li, 
          link_to('All Pages', builder_route([site_pages], :index))
        )
        if current_page
          if has_ancestors?
            current_page_ancestors.each do |a|
              o += content_tag(
                :li, 
                link_to(a.title, builder_route([a], :show))
              )
            end
          end
          o += content_tag(
            :li, 
            link_to(current_page.title, builder_route([current_page], :show))
          )
          o.html_safe
        end
      end
    end
  end

  def home_page
    @home_page ||= current_site.home_page
  end

  def is_home_page?(page)
    page == home_page
  end

  def new_page_children_links(prefix = "New")
    @new_page_children_links ||= begin
      content_tag(:div, :class => 'new-buttons') do
        if template_children.size > 1
          o = link_to("New Page", '#', :class => 'new button dropdown-trigger')
          o += content_tag(:ul) do
            o2 = ''
            template_children.select { |t| !t.maxed_out? }.each do |template|
              o2 += content_tag(
                :li, 
                link_to(
                  "#{prefix} #{template.title}", 
                  new_builder_site_page_path(
                    current_site, 
                    :template => template.slug,
                    :parent => current_page.slug
                  )
                )
              )
            end
            o2.html_safe
          end
        elsif template_children.size > 0
          template = template_children.first
          link_to(
            "#{prefix} #{template.title}", 
            new_builder_site_page_path(
              current_site, 
              :template => template.slug,
              :parent => current_page.slug
            ),
            :class => 'new button'
          )
        end
      end
    end
  end

  def page_status(page)
    if page.published?
      content_tag(:a, 'Published', :class => 'published disabled')
    else
      content_tag(:a, 'Draft', :class => 'draft disabled')
    end
  end

  def new_root_page_links
    new_pages = site_templates.not_maxed_out.can_be_root
    content_tag(:div, :class => 'new-buttons') do
      if new_pages.size > 1
        o = link_to("New Page", '#', :class => 'new button dropdown-trigger')
        o += content_tag(:ul) do
          o2 = ''
          new_pages.each do |template|
            o2 += content_tag(
              :li, 
              link_to(
                template.title, 
                new_builder_site_page_path(
                  current_site, 
                  :template => template.slug
                )
              )
            )
          end
          o2.html_safe
        end
      elsif new_pages.size == 1
        template = new_pages.first
        link_to(
          "New #{template.title}", 
          new_builder_site_page_path(
            current_site, 
            :template => template.slug
          ),
          :class => 'new button'
        )
      end
    end
  end

  def page_status(page)
    if page.published
      content_tag(:span, :class => 'page-status published') do
        o = content_tag(:i, nil, :class => 'icon-checkmark-circle')
        o += content_tag(:span, 'Published')
      end
    else
      content_tag(:span, :class => 'page-status draft') do
        o = content_tag(:i, nil, :class => 'icon-notification')
        o += content_tag(:span, 'Draft')
      end
    end
  end

end
