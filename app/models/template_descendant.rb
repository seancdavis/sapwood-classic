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

class TemplateDescendant < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :parent, :class_name => 'Template'
  belongs_to :child, :class_name => 'Template'

end
