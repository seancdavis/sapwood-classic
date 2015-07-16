module ErrorsHelper

  def not_found
    message = "Page not found at #{request.path}"
    error = ActionController::RoutingError.new(message)
    raise error
  end

end
