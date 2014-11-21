# == Schema Information
#
# Table name: page_type_field_groups
#
#  id           :integer          not null, primary key
#  page_type_id :integer
#  title        :string(255)
#  slug         :string(255)
#  position     :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

class PageTypeFieldGroup < ActiveRecord::Base

# ------------------------------------------ Plugins

include SiteSlug

# ------------------------------------------ Associations

belongs_to :page_type, :touch => true

has_one :site, :through => :page_type

has_many :fields, :class_name => 'PageTypeField', :dependent => :destroy

accepts_nested_attributes_for :fields

# ------------------------------------------ Scopes

scope :in_order, -> { order('position asc') }

# ------------------------------------------ Callbacks

before_save :set_position

def set_position
  self.position = 1 if self.position.blank?
end

after_save :remove_blank_fields

def remove_blank_fields
  fields.where("title = ''").destroy_all
end

end
