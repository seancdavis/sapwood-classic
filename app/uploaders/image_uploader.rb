# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  process :store_geometry

  after :store, :dynamic_versions

  def store_dir
    dir = "sites/#{model.site.slug}/media/images/#{model.idx}"
    if Rails.env.production?
      dir
    else
      "dev/#{dir}"
    end
  end

  version :thumb do
    process :resize_to_fill => [250,250]
  end

  # version :to_crop do
  #   process :resize_to_fit => [600,600]
  # end

  # raise self.model.to_yaml

  def dynamic_versions(file)
    croppings = model.site.image_croppings
    if croppings.size > 0
      
      if model.crop_x.present?
      resize_to_limit(500,500)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop!(x, y, w, h)
      end
    end
    end
  end

  # def crop
  #   if model.crop_x.present?
  #     resize_to_limit(500,500)
  #     manipulate! do |img|
  #       x = model.crop_x.to_i
  #       y = model.crop_y.to_i
  #       w = model.crop_w.to_i
  #       h = model.crop_h.to_i
  #       img.crop!(x, y, w, h)
  #     end
  #   end
  # end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_geometry
    img = ::Magick::Image::read(@file.file).first
    if model
      model.width = img.columns
      model.height = img.rows
    end
  end

end
