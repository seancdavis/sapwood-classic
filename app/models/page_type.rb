# == Schema Information
#
# Table name: page_types
#
#  id          :integer          not null, primary key
#  site_id     :integer
#  title       :string(255)
#  slug        :string(255)
#  description :text
#  icon        :string(255)
#  template    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class PageType < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :site

  has_many :pages
  has_many :page_type_field_groups
  has_many :page_type_fields, :through => :page_type_field_groups

  accepts_nested_attributes_for :page_type_field_groups
  accepts_nested_attributes_for :page_type_fields

  # ------------------------------------------ Instance Methods

  def groups
    page_type_field_groups
  end

  def fields
    page_type_fields
  end

end
