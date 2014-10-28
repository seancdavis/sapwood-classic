# == Schema Information
#
# Table name: page_type_fields
#
#  id                       :integer          not null, primary key
#  page_type_field_group_id :integer
#  title                    :string(255)
#  slug                     :string(255)
#  data_type                :string(255)
#  options                  :text
#  created_at               :datetime
#  updated_at               :datetime
#  required                 :boolean          default(FALSE)
#  position                 :integer          default(0)
#

FactoryGirl.define do
  factory :page_type_field do
    page_type_field_group_id 1
title "MyString"
slug "MyString"
data_type "MyString"
options "MyText"
  end

end
