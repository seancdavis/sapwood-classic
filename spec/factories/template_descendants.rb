# == Schema Information
#
# Table name: template_descendants
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :template_descendant do
    parent_id 1
child_id 1
  end

end
