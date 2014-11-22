class Builder::ImagesController < BuilderController

  include ImagesHelper

  def index
    if request.xhr?
      render :partial => 'content', :layout => false
    end
  end

  def create
    respond_to do |format|
      format.json do
        @image = Image.create!(image_params)
        render :json => @image
      end
    end
  end

  def destroy
    current_image.destroy
    redirect_to builder_route([site_images], :index), 
      :notice => t('notices.deleted', :item => 'Image')
  end

  private

    def image_params
      params.require(:image).permit(:image).merge(:site => current_site)
    end

end
