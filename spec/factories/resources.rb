# == Schema Information
#
# Table name: resources
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  slug             :string(255)
#  resource_type_id :integer
#  field_data       :text
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :resource do
    resource_type_id 1
field_data "MyText"
  end

end
