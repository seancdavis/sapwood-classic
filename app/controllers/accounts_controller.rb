class AccountsController < ApplicationController

  before_filter :authenticate_admin!, :except => [:home]

  def home
    if current_user.is_admin?
      redirect_to accounts_path
    else
      redirect_to current_user.last_site
    end
  end

  def index
    @accounts = Heartwood::Account.all
  end

end
