# == Schema Information
#
# Table name: settings
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :setting do
    title "MyString"
description "MyText"
body "MyText"
  end

end
