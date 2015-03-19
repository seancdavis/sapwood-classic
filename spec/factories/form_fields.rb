# == Schema Information
#
# Table name: form_fields
#
#  id            :integer          not null, primary key
#  form_id       :integer
#  title         :string(255)
#  data_type     :string(255)
#  options       :text
#  required      :boolean          default(FALSE)
#  position      :integer          default(0)
#  created_at    :datetime
#  updated_at    :datetime
#  slug          :string(255)
#  label         :string(255)
#  placeholder   :string(255)
#  default_value :string(255)
#  show_label    :boolean          default(TRUE)
#  hidden        :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :form_field do
    form_id 1
title "MyString"
data_type "MyString"
options "MyText"
required false
position 1
  end

end
