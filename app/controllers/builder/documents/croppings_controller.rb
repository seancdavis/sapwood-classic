class Builder::Documents::CroppingsController < Builder::DocumentsController

  def edit
    render(:layout => false) if request.xhr?
  end

  def update
    if current_file.update(:crop_data => params[:document][:crop_data].to_hash)
      redirect_to builder_route([current_file], :index), 
        :notice => t('notices.updated', :item => 'Image')
    else
      redirect_to builder_route([current_file], :index), 
        :notice => "Couldn't crop image."
    end
  end

end
