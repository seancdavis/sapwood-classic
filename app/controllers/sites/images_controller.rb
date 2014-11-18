class Sites::ImagesController < SitesController

  include Sites::ImagesHelper

  def index
    if request.xhr?
      if params[:content_only]
        render :partial => 'content', :layout => false
      else
        render :layout => false
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        @image = Heartwood::Image.create!(image_params)
        render :json => @image
      end
    end
  end

  def destroy
    current_image.destroy
    redirect_to site_route([site_images], :index), 
      :notice => t('notices.deleted', :item => 'Image')
  end

  private

    def image_params
      params.require(:image).permit(:image).merge(:site => current_site)
    end

end
