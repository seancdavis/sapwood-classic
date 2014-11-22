module ImagesHelper

  def site_images
    @site_images ||= current_site.images.by_idx
  end

  def current_image
    @current_image ||= begin
      if controller_name == 'images'
        current_site.images.find_by_idx(params[:idx])
      elsif controller_name == 'croppings'
        current_site.images.find_by_idx(params[:image_idx])
      end
    end
  end

  def page_images
    @page_images ||= current_page.images
  end

  def find_page_image(idx)
    image = page_images.select { |image| image.idx == idx.to_i }.first
    return image.image.url(:thumb) unless image.nil?
  end

  def cropped_image(image, version)
    crop = image.crop(version)
    unless crop.nil?
      content_tag(
        :div, 
        :class => 'cropbox',
        :data => {
          :x => crop.x_p,
          :y => crop.y_p,
          :width => crop.width_p,
          :height => crop.height_p,
        }
      ) do
        image_tag(image.image.url(:to_crop))
      end
    end
  end

end
