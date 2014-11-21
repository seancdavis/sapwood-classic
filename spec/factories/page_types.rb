# == Schema Information
#
# Table name: page_types
#
#  id             :integer          not null, primary key
#  site_id        :integer
#  title          :string(255)
#  slug           :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  page_templates :text
#  children       :text
#  label          :string(255)
#

FactoryGirl.define do
  factory :page_type do
    site_id 1
title "MyString"
slug "MyString"
description "MyText"
icon "MyString"
template "MyString"
  end

end
