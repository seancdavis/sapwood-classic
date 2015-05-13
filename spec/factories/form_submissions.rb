# == Schema Information
#
# Table name: form_submissions
#
#  id         :integer          not null, primary key
#  form_id    :integer
#  idx        :integer          default(0)
#  field_data :text
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :form_submission do
    form
    idx 1
    field_data {}
  end

end
