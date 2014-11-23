# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  image_uid  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  idx        :integer          default(0)
#  crop_data  :text
#  image_site :string(255)
#  image_name :string(255)
#

require 'rails_helper'

RSpec.describe Image, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
