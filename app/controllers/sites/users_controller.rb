class Sites::UsersController < SitesController

  def index
    @users = current_account.users.alpha
  end

  def new
    @user = User.new
  end

end
