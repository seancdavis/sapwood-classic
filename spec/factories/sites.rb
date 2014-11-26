# == Schema Information
#
# Table name: sites
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  slug         :string(255)
#  url          :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#  home_page_id :integer
#  git_url      :string(255)
#  local_repo   :string(255)
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
