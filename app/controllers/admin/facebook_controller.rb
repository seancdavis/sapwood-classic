class Admin::FacebookController < AdminController

  include ErrorsHelper

  def auth
    if current_user.email == 'sean@rocktree.us'
      if params[:code].present?
        code = params[:code]
        token = $facebook.get_access_token_info(code)
        current_user.update(
          :fb_access_token => token['access_token'],
          :fb_token_expires => token['expires'].to_i.seconds.from_now
        )
        redirect_to(
          builder_sites_path, 
          :notice => 'Successfully updated Facebook token.'
        )
      else
        redirect_to $facebook.url_for_oauth_code(:permissions => "manage_pages")
      end
    else
      not_found
    end
  end

end
