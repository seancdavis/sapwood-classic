# == Schema Information
#
# Table name: image_galleries
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  public     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :image_gallery do
    site_id 1
title "MyString"
slug "MyString"
public false
  end

end
