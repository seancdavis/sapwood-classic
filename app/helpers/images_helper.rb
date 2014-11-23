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

  def find_page_thumb(idx)
    image = page_images.select { |image| image.idx == idx.to_i }.first
    return image.image.thumb('200x200#').url unless image.nil?
  end

  def cropped_image(image, version)
    c = image.crop(version)
    magic = "#{c.width.to_i}x#{c.height.to_i}+#{c.x.to_i}+#{c.y.to_i}"
    image_tag(image.image.thumb(magic).thumb('250x375#').url)
  end

end
