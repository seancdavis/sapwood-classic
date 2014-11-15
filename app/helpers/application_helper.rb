module ApplicationHelper

  include RoutingHelper

  def data
    @data ||= {
      :title => current_site ? current_site.title : "rocktree"
    }
  end

  def admin?
    current_user.admin?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def simple_create(obj, redirect_action = :show, parents = [])
    obj.save ? redirect_to(route(parents + [obj], redirect_action), 
      :notice => t('notices.created', 
      :item => controller_name.humanize.titleize)) : render('new')
  end

end
