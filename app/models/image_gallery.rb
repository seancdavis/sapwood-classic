# == Schema Information
#
# Table name: image_galleries
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  public     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class ImageGallery < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :site

end
