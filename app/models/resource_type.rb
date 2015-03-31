# == Schema Information
#
# Table name: resource_types
#
#  id              :integer          not null, primary key
#  site_id         :integer
#  title           :string(255)
#  slug            :string(255)
#  description     :text
#  order_method    :string(255)
#  order_direction :string(255)
#  last_editor_id  :integer
#  has_show_view   :boolean          default(TRUE)
#  created_at      :datetime
#  updated_at      :datetime
#

class ResourceType < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :site, :touch => true
  belongs_to :last_editor, :class_name => 'User'

  has_many :template_resource_types
  has_many :templates, :through => :template_resource_types

  # ------------------------------------------ Scopes

  scope :alpha, -> { order('title asc') }

  # ------------------------------------------ Validations

  validates :title, :presence => true

end
