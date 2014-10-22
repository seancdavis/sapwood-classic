# == Schema Information
#
# Table name: page_type_fields
#
#  id                       :integer          not null, primary key
#  page_type_field_group_id :integer
#  title                    :string(255)
#  slug                     :string(255)
#  data_type                :string(255)
#  options                  :text
#  created_at               :datetime
#  updated_at               :datetime
#

class PageTypeField < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :page_type_field_group

  # ------------------------------------------ Instance Methods

  def group
    page_type_field_group
  end

end
