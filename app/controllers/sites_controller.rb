class SitesController < ApplicationController

  before_filter :authenticate_user!
  before_action :cache_user_state

  include SitesHelper

  def index
    redirect_to site_path(current_user.last_site)
  end

  def show
  end

  def edit
  end

  private

    def create_params
    end

    def update_params
      create_params
    end

end
