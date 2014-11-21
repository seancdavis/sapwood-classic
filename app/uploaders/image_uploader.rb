# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  storage :file

  def store_dir
    "media/#{model.site.slug}/images/#{model.id}"
  end

  version :thumb do
    process :resize_to_fill => [250,250]
  end

  version :to_crop do
    process :resize_to_fit => [600,600]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
