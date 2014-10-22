# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  gallery_id :integer
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Image < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :image_gallery

end
