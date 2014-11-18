module Sites
  module ImagesHelper

    def site_images
      @site_images ||= current_site.images.by_idx
    end

    def current_image
      @current_image ||= begin
        if controller_name == 'images'
          current_site.images.find_by_idx(params[:idx])
        end
      end
    end

  end
end
