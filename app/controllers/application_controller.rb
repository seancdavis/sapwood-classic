class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  # redirect to admin dashboard after signing in
  def after_sign_in_path_for(user)
    root_path
  end

  # redirect back to sign in form when signed out
  def after_sign_out_path_for(user)
    root_path
  end

end
