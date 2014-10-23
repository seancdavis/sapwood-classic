# == Schema Information
#
# Table name: page_type_field_groups
#
#  id           :integer          not null, primary key
#  page_type_id :integer
#  title        :string(255)
#  slug         :string(255)
#  position     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class PageTypeFieldGroup < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :page_type

  has_one :site, :through => :page_type

  has_many :page_type_fields

  # ------------------------------------------ Instance Methods

  def fields
    page_type_fields
  end

end
