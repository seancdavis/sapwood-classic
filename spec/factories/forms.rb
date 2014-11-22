# == Schema Information
#
# Table name: forms
#
#  id                  :integer          not null, primary key
#  site_id             :integer
#  title               :string(255)
#  slug                :string(255)
#  description         :text
#  body                :text
#  thank_you_body      :text
#  notification_emails :text
#  created_at          :datetime
#  updated_at          :datetime
#  key                 :string(255)
#

FactoryGirl.define do
  factory :form do
    site_id 1
title "MyString"
slug "MyString"
description "MyText"
body "MyText"
thank_you_body "MyText"
notification_emails "MyText"
  end

end
