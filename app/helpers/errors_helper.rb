module ErrorsHelper

  def not_found
    error = ActionController::RoutingError.new('Not Found')
    raise error
  end

end
