module DocumentsHelper

  def site_documents
    @site_documents ||= current_site.documents.by_idx
  end

  def site_files
    site_documents
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

  def find_page_thumb(idx)
    file = current_site.documents.find_by_idx(idx)
    return file.thumbnail unless file.nil?
  end

  def cropped_image(image, version)
    unless image.nil?
      c = image.crop(version)
      if c.nil?
        c = current_site.image_croppings.find_by_slug(version)
        image_tag(image.image.thumb("#{c.width.to_i}x#{c.height.to_i}#").url)
      else
        magic = "#{c.crop_width.to_i}x#{c.crop_height.to_i}+#{c.x.to_i}+#{c.y.to_i}"
        image_tag(image.image.thumb(magic).thumb("#{c.width.to_i}x#{c.height.to_i}#").url)
      end
    end
  end

end
