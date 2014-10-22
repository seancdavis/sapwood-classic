class Sites::UsersController < SitesController

  def index
    @users = current_account.users.alpha
  end

end
