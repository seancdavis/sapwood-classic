# == Schema Information
#
# Table name: page_type_field_groups
#
#  id           :integer          not null, primary key
#  page_type_id :integer
#  title        :string(255)
#  slug         :string(255)
#  position     :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

FactoryGirl.define do
  factory :page_type_field_group do
    page_type_id 1
title "MyString"
slug "MyString"
position 1
  end

end
