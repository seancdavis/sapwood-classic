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

  # ------------------------------------------ Attributes

  attr_accessor :delete_group

  # ------------------------------------------ Associations

  belongs_to :site

  has_many :pages
  has_many :groups, :class_name => 'PageTypeFieldGroup', :dependent => :destroy
  has_many :fields, :class_name => 'PageTypeField', :through => :groups

  accepts_nested_attributes_for :groups
  accepts_nested_attributes_for :fields

  # ------------------------------------------ Callbacks

  after_save :remove_blank_groups

  def remove_blank_groups
    groups.where("title = ''").destroy_all
  end

end
