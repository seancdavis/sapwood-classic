class AccountsController < ApplicationController

  include AccountsHelper

  def show
    render('admin') if current_user.is_admin?
    @account = current_account
  end

end
