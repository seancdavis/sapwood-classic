module ErrorsHelper

  def not_found
    message = "Page not found at #{request.path}"
    error = ActionController::RoutingError.new(message)
    raise error
  end

  def site_errors
    @site_errors ||= current_site.theme_errors.recent.includes(:user)
  end

  def current_error
    @current_error ||= begin
      p = params[:id] || params[:error_id]
      site_errors.select { |e| e.id == p.to_i }.first
    end
  end

  def errors_breadcrumbs
    link_to("site errors", builder_route([site_errors], :index))
  end

  def error_created(error)
    date = error.created_at.strftime("%h %d")
    by = error.user.nil? ? '' :
      " by #{content_tag(:span, error.user.display_name)}"
    by += " [#{content_tag(:span, error.ip)}]"
    content_tag(:span, :class => 'last-edited') do
      "Discovered #{content_tag(:span, date)}#{by}".html_safe
    end
  end

  def quick_error_status(error)
    if error.open?
      link_to('', '#', :class => 'disabled not-complete')
    else
      link_to('', '#', :class => 'disabled complete')
    end
  end

  def error_status_filters
    o = link_to(
      "All",
      builder_site_errors_path(current_site, :error_status => 'all'),
      :class => params[:error_status] == 'all' ? 'active' : nil
    )
    o += link_to(
      "Open",
      builder_site_errors_path(current_site, :error_status => 'open'),
      :class => "not-complete
        #{params[:error_status] == 'open' ? 'active' : nil}"
    )
    o += link_to(
      "Closed",
      builder_site_errors_path(current_site, :error_status => 'closed'),
      :class => "complete
        #{params[:error_status] == 'closed' ? 'active' : nil}"
    )
    o.html_safe
  end

end
