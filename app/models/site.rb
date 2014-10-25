# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  title       :string(255)
#  slug        :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Site < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include Slug

  # ------------------------------------------ Associations

  belongs_to :account

  has_many :page_types
  has_many :pages, :through => :page_types
  has_many :page_type_field_groups, :through => :page_types, :source => :groups
  has_many :page_type_fields, :through => :page_type_field_groups, :source => :fields
  has_many :forms
  has_many :image_galleries
  has_many :images, :through => :image_galleries

end
