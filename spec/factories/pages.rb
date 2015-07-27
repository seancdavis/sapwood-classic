# == Schema Information
#
# Table name: pages
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  slug          :string(255)
#  body          :text
#  ancestry      :string(255)
#  published     :boolean          default(FALSE)
#  created_at    :datetime
#  updated_at    :datetime
#  position      :integer          default(0)
#  page_path     :string(255)
#  site_id       :integer
#  field_data    :json
#  template_name :string(255)
#  meta          :json
#  field_search  :text
#

FactoryGirl.define do
  factory :page do
    page_type_id 1
title "MyString"
slug "MyString"
description "MyText"
body "MyText"
ancestry "MyString"
published false
field_data "MyText"
  end

end
