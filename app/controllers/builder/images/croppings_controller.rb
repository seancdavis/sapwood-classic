class Builder::Images::CroppingsController < Builder::ImagesController

  def edit
    render(:layout => false) if request.xhr?
  end

  def update
    if current_image.update(:crop_data => params[:image][:crop_data].to_hash)
      redirect_to builder_route([current_image], :index), 
        :notice => t('notices.updated', :item => 'Image')
    else
      redirect_to builder_route([current_image], :index), 
        :notice => "Couldn't crop image."
    end
  end

end
