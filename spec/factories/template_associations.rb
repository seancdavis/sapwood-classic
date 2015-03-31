# == Schema Information
#
# Table name: template_associations
#
#  id                :integer          not null, primary key
#  left_template_id  :integer
#  right_template_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

FactoryGirl.define do
  factory :template_association do
    left_template_id 1
right_template_id 1
  end

end
