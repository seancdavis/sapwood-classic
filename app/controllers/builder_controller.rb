class BuilderController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include(
    ApplicationHelper, 
    RoutingHelper, 
    UsersHelper, 
    SitesHelper, 
    PageTypesHelper, 
    PagesHelper
  )

  before_filter :init_options

  def home
    authenticate_user!
    # if user_signed_in?
      if has_sites? || admin?
        redirect_to(has_multiple_sites? ? builder_sites_path : builder_site_path(only_site))
      else
        sign_out_and_redirect(current_user)
      end
    # else
    #   # render(:layout => 'application')
    # end
  end

  private

    def init_options
      @options = {
        'sidebar' => true,
        'body_classes' => ''
      }
    end

end
