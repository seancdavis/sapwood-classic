# == Schema Information
#
# Table name: page_resources
#
#  id          :integer          not null, primary key
#  page_id     :integer
#  resource_id :integer
#  field_data  :text
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :page_resource do
    page_id 1
resource_id 1
field_data "MyText"
  end

end
