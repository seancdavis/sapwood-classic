# == Schema Information
#
# Table name: resource_types
#
#  id              :integer          not null, primary key
#  site_id         :integer
#  title           :string(255)
#  slug            :string(255)
#  description     :text
#  order_method    :string(255)
#  order_direction :string(255)
#  last_editor_id  :integer
#  has_show_view   :boolean          default(TRUE)
#  created_at      :datetime
#  updated_at      :datetime
#

FactoryGirl.define do
  factory :resource_type do
    
  end

end
