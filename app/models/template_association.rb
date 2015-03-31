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

class TemplateAssociation < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :left_template, :class_name => 'Template'
  belongs_to :right_template, :class_name => 'Template'

end
