class SitesController < ApplicationController

  include SitesHelper

  def index
    redirect_to current_user.sites.first
  end

  def show
  end

end
