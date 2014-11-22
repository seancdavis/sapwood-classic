module ApplicationHelper

  include RoutingHelper

  def data
    @data ||= {
      :title => current_site ? current_site.title : "rocktree"
    }
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
