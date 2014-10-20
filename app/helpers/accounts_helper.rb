module AccountsHelper

  def current_account
    @current_account ||= current_user.account
  end

end
