# == Schema Information
#
# Table name: menu_items
#
#  id         :integer          not null, primary key
#  menu_id    :integer
#  page_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  url        :string(255)
#  position   :integer
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :menu_item do
    menu_id 1
page_id 1
title "MyString"
url "MyString"
position 1
ancestry "MyString"
  end

end
