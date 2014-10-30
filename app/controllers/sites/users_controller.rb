class Sites::UsersController < SitesController

  before_action :set_user, :except => [:index, :create]

  def index
    @users = current_site.users.includes(:site_users)
  end

  def new
  end

  def create
    @user = Heartwood::User.find_by_email(params[:user][:email])
    @user = Heartwood::User.create!(create_params) if @user.nil?
    if @user.save
      @site_user = Heartwood::SiteUser.create!(:user => @user, 
        :site => current_site)
      if @site_user.save
        redirect_to(site_route([@user], :index), 
          :notice => t('notices.created', :item => "User"))
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def destroy
    site_users = Heartwood::SiteUser.where(:user_id => params[:id])
    site_users.destroy_all
    redirect_to(site_route([@user], :index), 
      :notice => t('notices.deleted', :item => "User"))
  end

  private

    def set_user
      if action_name == 'new'
        @user = Heartwood::User.new(params[:user] ? create_params : nil)
      else
        @user = current_site.users.find_by_id(params[:id])
      end
      not_found if @user.nil?
    end

    def create_params
      params.require(:user).permit(:name, :email, :password, 
        :password_confirmation)
    end

end
