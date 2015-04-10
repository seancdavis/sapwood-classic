# == Schema Information
#
# Table name: site_settings
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :site_setting do
    site_id 1
title "MyString"
slug "MyString"
body "MyText"
  end

end
