# == Schema Information
#
# Table name: sites
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  slug         :string(255)
#  url          :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#  home_page_id :integer
#  git_url      :string(255)
#  local_repo   :string(255)
#

class Site < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include Slug

  # ------------------------------------------ Attributes

  serialize :crop_settings, Hash

  # ------------------------------------------ Associations

  has_many :site_users
  has_many :users, :through => :site_users
  has_many :page_types, :dependent => :destroy
  has_many :pages, :through => :page_types, :dependent => :destroy
  has_many :page_type_field_groups, :through => :page_types, 
    :source => :groups, :dependent => :destroy
  has_many :page_type_fields, :through => :page_type_field_groups, 
    :source => :fields, :dependent => :destroy
  has_many :forms, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :image_croppings

  belongs_to :home_page, :class_name => 'Page'

  accepts_nested_attributes_for :image_croppings

  # ------------------------------------------ Scopes

  scope :last_updated, -> { order('updated_at desc') }

  # ------------------------------------------ Validations

  validates :title, :presence => true

  # ------------------------------------------ Callbacks

  after_save :remove_blank_image_croppings

  def remove_blank_image_croppings
    image_croppings.where("title = ''").destroy_all
  end

  # ------------------------------------------ Instance Method

  def croppers
    crop_settings
  end

end
