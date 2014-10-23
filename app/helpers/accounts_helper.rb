module AccountsHelper

  def current_account
    @current_account ||= current_site.account
  end

end
