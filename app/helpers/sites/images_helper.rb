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

    def page_images
      @page_images ||= begin
        current_page.images
      end
    end

    def find_page_image(idx)
      image = page_images.select { |image| image.idx == idx.to_i }.first
      image.image.url(:thumb)
    end

  end
end
