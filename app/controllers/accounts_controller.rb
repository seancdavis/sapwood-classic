class AccountsController < ApplicationController

  include AccountsHelper

  def show
    # render('admin') if current_user.is_admin?
    # @account = current_account
    redirect_to current_user.sites.first
  end

end
