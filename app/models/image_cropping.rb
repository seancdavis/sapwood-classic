# == Schema Information
#
# Table name: image_croppings
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  site_id    :integer
#  min_width  :integer
#  min_height :integer
#  ratio      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ImageCropping < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :site, :touch => true

  # ------------------------------------------ Callbacks

  after_save :update_images

  def update_images
    site.images.each do |image|
      if image.crop(slug).nil?
        crop_data = image.crop_data.merge(
          slug => {
            'x' => '0',
            'y' => '0',
            'width' => min_width.to_s,
            'height' => min_height.to_s,
          }
        )
        image.update_columns(:crop_data => crop_data)
      end
    end
  end

  # ------------------------------------------ Instance Methods

  def aspect_ratio
    unless ratio.blank?
      dimensions = ratio.split(':')
      unless dimensions.empty?
        dimensions.first.to_f / dimensions.last.to_f
      end
    end
  end

end
