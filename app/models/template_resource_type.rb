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

class TemplateResourceType < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :template
  belongs_to :resource_type

end
