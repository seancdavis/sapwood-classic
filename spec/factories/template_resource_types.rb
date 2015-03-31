# == Schema Information
#
# Table name: template_resource_types
#
#  id               :integer          not null, primary key
#  template_id      :integer
#  resource_type_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :template_resource_type do
    template_id 1
resource_type_id 1
  end

end
