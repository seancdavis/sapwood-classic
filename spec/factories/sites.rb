# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  title       :string(255)
#  slug        :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :site do
    account_id 1
title "MyString"
slug "MyString"
url "MyString"
description "MyText"
  end

end
