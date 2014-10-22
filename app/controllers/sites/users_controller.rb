class Sites::UsersController < SitesController

  before_action :set_user, :except => [:index]

  def index
    @users = current_account.users.alpha
  end

  def new
  end

  def create
    @user.save ? redirect_to(routes[:index], :notice => t('notices.created', 
      :item => 'User')) : render('new')
  end

  private

    def set_user
      if action_name == 'new' || action_name == 'create'
        @user = User.new(params[:user] ? create_params : nil)
      else
        @user = current_account.users.where(:idx => params[:idx]).first
      end
      not_found if @user.nil?
    end

    def create_params
      params.require(:user).permit(:name, :email, :password, 
        :password_confirmation).merge(:account => current_account)
    end

end
