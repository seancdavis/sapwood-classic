# == Schema Information
#
# Table name: page_images
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  image_id   :integer
#  field_name :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class PageImage < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :page
  belongs_to :image

end
