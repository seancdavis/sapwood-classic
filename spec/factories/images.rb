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

FactoryGirl.define do
  factory :image do
    gallery_id 1
image "MyString"
  end

end
