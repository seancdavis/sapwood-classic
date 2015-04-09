class Builder::ErrorsController < BuilderController

  before_filter :verify_admin

  include ErrorsHelper

  def index
    @errors = site_errors
    if params[:error_status] && params[:error_status] != 'all'
      @errors = @errors.select { |t| t.send("#{params[:error_status]}?") }
    elsif params[:error_status] != 'all'
      redirect_to(
        builder_site_errors_path(current_site, :error_status => 'open')
      )
    end
    @errors = Kaminari.paginate_array(@errors).page(params[:page] || 1).per(10)
  end

  def close
    if request.referrer.nil?
      redirect_to builder_route([site_errors], :index)
    else
      current_error.close!
      redirect_to request.referrer, :notice => 'Error closed!'
    end
  end

end
