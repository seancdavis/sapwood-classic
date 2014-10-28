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
#  required                 :boolean          default(FALSE)
#  position                 :integer          default(0)
#

class PageTypeField < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :page_type_field_group

  has_one :page_type, :through => :page_type_field_group
  has_one :site, :through => :page_type

  # ------------------------------------------ Scopes

  default_scope { order('position asc') }

  # ------------------------------------------ Instance Methods

  def group
    page_type_field_group
  end

end
