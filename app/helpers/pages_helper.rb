module PagesHelper

  def site_pages
    @site_pages ||= current_site.pages
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
        page = current_site.pages.find_by_slug(p)
        if page.nil?
          nil
        else
          @current_page_type = page.page_type
          page
        end
      end
    end
  end

  def current_page_template
    @current_page_template ||= current_page.template
  end

  def current_page_template_class
    slug = @current_page_template
    slug = "_#{slug}" if slug[0] =~ /[0-9]/
    slug
  end

  def current_page_parent
    @current_page_parent ||= begin
      if current_page
        current_page.parent || 
        current_site.pages.find_by_slug(params[:parent])
      end
    end
  end

  def current_page_children
    @current_page_children ||= current_page.children.in_position
  end

  def current_page_children_paginated
    @current_page_children ||= begin
      current_page_children.page(params[:page]).per(10)
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

  def home_page
    @home_page ||= current_site.home_page
  end

  def is_home_page?(page)
    page == home_page
  end

  def new_page_children_links(prefix = "New")
    @new_page_children_links ||= begin
      output = ''
      page_type_children.each do |page_type|
        output += link_to(
          "#{prefix} #{page_type.label}", 
          new_builder_site_page_path(
            current_site, 
            :page_type => page_type.slug,
            :parent => current_page.slug
          ),
          :class => 'new'
        )
      end
      output.html_safe
    end
  end

  def page_status(page)
    if page.published?
      content_tag(:a, 'Published', :class => 'published disabled')
    else
      content_tag(:a, 'Draft', :class => 'draft disabled')
    end
  end

end
